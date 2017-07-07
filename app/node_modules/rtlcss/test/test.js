/* global describe */
/* global it */
var assert = require('assert')
var rtlcss = require('../lib/rtlcss.js')
var tests = {
  '# Background:': require('./data/background.js'),
  '# Background Image:': require('./data/background-image.js'),
  '# Background Position:': require('./data/background-position.js'),
  '# Properties:': require('./data/properties.js'),
  '# Values:': require('./data/values.js'),
  '# Values (N Value Syntax):': require('./data/values-n-syntax.js'),
  '# Transforms:': require('./data/transforms.js'),
  '# Transform Origin:': require('./data/transform-origin.js'),
  '# RTLCSS (Options):': require('./data/rtlcss-options.js'),
  '# RTLCSS (Directives):': require('./data/rtlcss-directives.js'),
  '# RTLCSS (String Map):': require('./data/rtlcss-stringMap.js'),
  '# RTLCSS (Plugins):': require('./data/rtlcss-plugins.js'),
  '# Special:': require('./data/special.js')
}
var key
for (key in tests) {
  var group = tests[key]
  describe(key, function () {
    for (var i = 0; i < group.length; i++) {
      var item = group[i]
      ;(function (test) {
        it(test.should, function (done) {
          assert.equal(rtlcss.process(test.input, test.options, test.plugins), test.expected)
          done()
        })
      })(item)
      if (item.reversable) {
        (function (test) {
          it(test.should + ' <REVERESE>', function (done) {
            assert.equal(rtlcss.process(test.expected, test.options, test.plugins), test.input)
            done()
          })
        })(item)
      }
    }
  })
}
