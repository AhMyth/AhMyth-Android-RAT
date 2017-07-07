/* global process */
'use strict'
var fs = require('fs')
var path = require('path')
var findup = require('findup')
var stripJSONComments = require('strip-json-comments')
var config = {}
var configSources = ['package.json', '.rtlcssrc', '.rtlcss.json']

module.exports.load = function (configFilePath, cwd, overrides) {
  if (configFilePath) {
    return override(
      JSON.parse(
        stripJSONComments(
          fs.readFileSync(configFilePath, 'utf-8').trim())), overrides)
  }

  var directory = cwd || process.cwd()
  config = loadConfig(directory)
  if (!config) {
    var evns = [process.env.USERPROFILE, process.env.HOMEPATH, process.env.HOME]
    for (var x = 0; x < evns.length; x++) {
      if (!evns[x]) {
        continue
      }
      config = loadConfig(evns[x])
      if (config) {
        break
      }
    }
  }

  if (config) {
    override(config, overrides)
  }
  return config
}

function loadConfig (dir) {
  for (var x = 0; x < configSources.length; x++) {
    var found
    var source = configSources[x]
    try {
      found = findup.sync(dir, source)
    } catch (e) {
      continue
    }

    if (found) {
      var configFilePath = path.normalize(path.join(found, source))
      try {
        config = JSON.parse(
          stripJSONComments(
            fs.readFileSync(configFilePath, 'utf-8').trim()))
      } catch (e) {
        throw new Error(e + ' ' + configFilePath)
      }

      if (source === 'package.json') {
        config = config.rtlcssConfig
      }

      if (config) {
        return config
      }
    }
  }
}

function override (to, from) {
  if (to && from) {
    for (var p in from) {
      if (typeof to[p] === 'object') {
        override(to[p], from[p])
      } else {
        to[p] = from[p]
      }
    }
  }
  return to
}
