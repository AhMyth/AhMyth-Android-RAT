/* global process */
/* global describe */
/* global it */
var assert = require('assert')
var spawn = require('child_process').spawn
var fs = require('fs')

function run_cmd (cmd, args, done) {
  var child = spawn(cmd, args)
  var resp = ''
  var err = ''
  child.stderr.on('data', function (error) { err += error })
  child.stdout.on('data', function (buffer) { resp += buffer.toString() })
  child.stdout.on('end', function () { done(err, resp) })
}

var configPath = './test/css/config.json'
var inputPath = './test/css/input.css'
var expectedPath = './test/css/input.expected.css'
var outputPath = './test/css/input.rtl.css'

describe('# CLI', function () {
  it('Should succeed', function (done) {
    run_cmd('node', ['./bin/rtlcss.js', inputPath, '--config', configPath, '--silent', ''], function (err, resp) {
      if (err) throw new Error(err)
      fs.readFile(expectedPath, 'utf-8', function (err, expected) {
        if (err) throw new Error(err)
        fs.readFile(outputPath, 'utf-8', function (err, output) {
          if (err) throw new Error(err)
          assert.equal(expected, output)
          fs.unlink(outputPath, function () {
            done()
          })
        })
      })
    })
  })
})
