require 'coffee-errors'

path = require 'path'
chai = require 'chai'
sinon = require 'sinon'
gutil = require 'gulp-util'
# using compiled JavaScript file here to be sure module works
print = require '../lib/gulp-print.js'

expect = chai.expect
chai.use require 'sinon-chai'

describe 'gulp-print', ->
  beforeEach ->
    sinon.stub print, 'log'

  afterEach ->
    print.log.restore()

  describe 'passing formatting function', ->
    it 'logs file path using default formatter', (done) ->
      stream = print()
      filepath = path.join process.cwd(), 'foo/bar.js'

      stream.on 'end', ->
        expect(print.log).to.have.been.calledWith gutil.colors.magenta path.relative process.cwd(), filepath
        done()

      stream.write new gutil.File path: filepath
      stream.end()

    it 'logs file paths using custom formatter', (done) ->
      stream = print (filepath) -> "Hello #{filepath}"
      filepath = path.join process.cwd(), 'foo/bar.js'

      stream.on 'end', ->
        expect(print.log).to.have.been.calledWith "Hello #{gutil.colors.magenta path.relative process.cwd(), filepath}"
        done()

      stream.write new gutil.File path: filepath
      stream.end()

