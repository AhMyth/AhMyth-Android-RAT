#!/usr/bin/env node

var path = require('path')
var fs = require('fs')
var sys = require('util')
var chalk = require('chalk')
var mkdirp = require('mkdirp')
var postcss = require('postcss')
var rtlcss = require('../lib/rtlcss')
var configLoader = require('../lib/config-loader')

var input, output, directory, ext, config, currentErrorcode, arg
var args = process.argv.slice(2)
var shouldBreak = false

process.on('exit', function () { process.reallyExit(currentErrorcode) })

function printWarning () {
  console.warn(chalk.yellow.apply(this, printWarning.arguments))
}

function printInfo () {
  console.info(chalk.green.apply(this, printInfo.arguments))
}

function printError () {
  console.error(chalk.red.apply(this, printError.arguments))
}

function printHelp () {
  console.log('Usage: rtlcss [option option=parameter ...] [source] [destination]')
  console.log('')
  /*eslint-disable*/
  var options = [
    'Option '       , 'Description ',
    '--------------', '----------------------------------------------',
    '-h,--help'     , 'Print help (this message) and exit.',
    '-v,--version'  , 'Print version number and exit.',
    '-c,--config'   , 'Path to configuration settings file.',
    '- ,--stdin'    , 'Read from stdin stream.',
    '-d,--dirctory' , 'Process all *.css files from input directory (recursive).',
    '-e,--ext'      , 'Used with -d option to set the output files extension.\n\t\t Default: ".rtl.css".',
    '-s,--silent'   , 'Silent mode, no warnings or errors are printed.'
  ]
  /*eslint-enable */
  for (var x = 0; x < options.length; x++) {
    console.log(options[x++], '\t', options[x])
  }
  console.log('')
  console.log('*If no destination is specified, output will be written to the same input folder as {source}.rtl.{ext}')
  console.log('')
  printInfo('RTLCSS version: ' + require('../package.json').version)
  printInfo('Report issues to: https://github.com/MohammadYounes/rtlcss/issues')
}
while ((arg = args.shift())) {
  switch (arg) {
    case '-h':
    case '--help':
      printHelp()
      shouldBreak = true
      break
    case '-v':
    case '--version':
      printInfo('rtlcss version: ' + require('../package.json').version)
      shouldBreak = true
      break
    case '-c':
    case '--config':
      arg = args.shift()
      try {
        config = configLoader.load(path.resolve(arg))
      } catch (e) {
        printError('rtlcss: invalid config file. ', e)
        shouldBreak = true
        currentErrorcode = 1
      }
      break
    case '-d':
    case '--directory':
      directory = true
      break
    case '-e':
    case '--ext':
      ext = args.shift()
      break
    case '-s':
    case '--silent':
      console.log = console.info = console.warn = function () {}
      break
    case '-':
    case '--stdin':
      input = '-'
      break
    default:
      if (arg[0] === '-') {
        printError('rtlcss: unknown option. ' + arg)
        shouldBreak = true
      } else {
        if (!input) {
          input = path.resolve(arg)
        } else if (!output) {
          output = path.resolve(arg)
        }
      }
      break
  }
}

if (!shouldBreak) {
  if (!directory && !input) {
    printError('rtlcss: no input file')
    console.log('')
    printHelp()
    shouldBreak = true
  }
  if (!config && input !== '-') {
    try {
      var cwd = input
      if (directory !== true) {
        cwd = path.dirname(input)
      }
      config = configLoader.load(null, cwd)
    } catch (e) {
      printError('rtlcss: invalid config file. ', e)
      currentErrorcode = 1
      shouldBreak = true
    }
  }
}

if (!shouldBreak) {
  if (!output && input !== '-') {
    if (directory !== true) {
      output = path.extname(input) ? input.replace(/\.[^.]*$/, function (ext) { return '.rtl' + ext }) : input + '.rtl'
    } else {
      output = input
    }
  }

  var processCSSFile = function (e, data, outputName) {
    if (e) {
      printError('rtlcss: ' + e.message)
      return
    }
    var result
    var opt = { map: false }
    if (input !== '-') {
      opt.from = input
      opt.to = output
    }
    if (!config) {
      printWarning('rtlcss: Warning! No config present, using defaults.')
      result = postcss([rtlcss]).process(data, opt)
    } else {
      if ('map' in config === true && input !== '-') {
        opt.map = config.map
      }
      result = postcss([rtlcss.configure(config)]).process(data, opt)
    }

    if (output) {
      var savePath = outputName
      if (directory !== true) {
        savePath = output
      }
      printInfo('Saving:', savePath)
      fs.writeFile(savePath, result.css, 'utf8', function (err) { err && printError(err) })
      if (result.map) {
        fs.writeFile(savePath + '.map', result.map, 'utf8', function (err) { err && printError(err) })
      }
    } else {
      sys.print(result.css)
    }
  }

  var walk = function (dir, done) {
    fs.readdir(dir, function (error, list) {
      if (error) {
        return done(error)
      }
      var i = 0
      ;(function next () {
        var file = list[i++]
        if (!file) {
          return done(null)
        }
        file = dir + path.sep + file
        fs.stat(file, function (err, stat) {
          if (err) {
            printError(err)
          } else if (stat && stat.isDirectory()) {
            walk(file, function (err) {
              if (err) {
                printError(err)
              } else {
                next()
              }
            })
          } else {
            // process only *.css
            if (/\.(css)$/.test(file)) {
              // compute output directory
              var relativePath = path.relative(input, file).split(path.sep)
              relativePath.pop()
              relativePath.push(path.basename(file).replace('.css', ext || '.rtl.css'))

              // set rtl file name
              var rtlFile = path.join(output, relativePath.join(path.sep))

              // create output directory if it does not exist
              var dirName = path.dirname(rtlFile)
              if (!fs.existsSync(dirName)) {
                mkdirp.sync(dirName)
              }

              // read and process the file.
              fs.readFile(file, 'utf8', function (e, data) {
                try {
                  processCSSFile(e, data, rtlFile)
                } catch (e) {
                  printError('rtlcss: error processing file', file)
                  printError(e)
                }
              })
            }
            next()
          }
        })
      })()
    })
  }

  if (input !== '-') {
    if (directory !== true) {
      fs.stat(input, function (error, stat) {
        if (error) {
          printError(error)
        } else if (stat && stat.isDirectory()) {
          printError('rtlcss: Input expected to be a file, use -d option to process a directory.')
        } else {
          fs.readFile(input, 'utf8', function (e, data) {
            try {
              processCSSFile(e, data)
            } catch (e) {
              printError('rtlcss: error processing file', input)
              printError(e)
            }
          })
        }
      })
    } else {
      walk(input, function (error) {
        if (error) {
          printError('rtlcss: ' + error)
        }
      })
    }
  } else {
    process.stdin.resume()
    process.stdin.setEncoding('utf8')

    var buffer = ''
    process.stdin.on('data', function (data) {
      buffer += data
    })
    process.on('SIGINT', function () {
      processCSSFile(false, buffer)
      process.exit()
    })
    process.stdin.on('end', function () {
      processCSSFile(false, buffer)
    })
  }
}
