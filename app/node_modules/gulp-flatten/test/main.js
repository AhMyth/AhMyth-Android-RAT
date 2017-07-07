var should = require('should');
var flatten = require('../');
var File = require('gulp-util').File;
var gulp = require('gulp');
var path = require('path');
var fileInstance;

describe('gulp-flatten', function () {

  beforeEach(function () {
    fileInstance = new File({
      cwd: '/some/project/',
      base: '/some/project/src/',
      path: '/some/project/src/assets/css/app.css',
      contents: new Buffer('html { background-color: #777; }')
    });
  });

  describe('flatten()', function () {
    it('should strip relative path without options', function (done) {
      var stream = flatten();
      stream.on('error', done);
      stream.on('data', function(newFile) {
        should.exist(newFile);
        should.exist(newFile.path);
        should.exist(newFile.relative);

        newFile.relative.should.equal('app.css');
        done();
      });
      stream.write(fileInstance);
    });

    it('should replace relative path with option path', function (done) {
      var stream = flatten({newPath: 'new/path'});
      stream.on('error', done);
      stream.on('data', function(newFile) {
        should.exist(newFile);
        should.exist(newFile.path);
        should.exist(newFile.relative);

        newFile.relative.should.equal('new/path/app.css'.split('/').join(path.sep));
        done();
      });
      stream.write(fileInstance);
    });

    it('should emit arg error with nonstring option', function (done) {
      var stream = flatten(123);
      stream.on('error', function (err) {
        should.exist(err);
        should.exist(err.message);
        should.ok(err.message === 'Path must be a string. Received undefined'
          || err.message === 'Arguments to path.join must be strings')
        done();
      });
      stream.write(fileInstance);
    });

    it('should ignore directories', function (done) {
      var stream = flatten();

      stream.on('error', done);
      stream.on('data', function(newFile) {
        should.exist(newFile);
        should.exist(newFile.path);
        should.exist(newFile.relative);

        newFile.relative.should.equal('test.css');
        done();
      });

      gulp.task('dottask', function () {
        gulp.src(path.join(__dirname, '/test_dir/**/*.css'))
          .pipe(stream);
      });

      gulp.start('dottask');
    });

    it('should strip relative path at the specified depth if depth option is passed', function (done) {
      var stream = flatten({includeParents: 2});
      stream.on('error', done);
      stream.on('data', function(newFile) {
        should.exist(newFile);
        should.exist(newFile.path);
        should.exist(newFile.relative);

        newFile.relative.should.equal('one/two/app.css'.split('/').join(path.sep));
        done();
      });

      fileInstance.path = '/some/project/src/one/two/three/four/app.css';
      stream.write(fileInstance);
    });

    it('should leave path from the end if depth option is passed as negative number', function (done) {
      var stream = flatten({includeParents: -2});
      stream.on('error', done);
      stream.on('data', function(newFile) {
        should.exist(newFile);
        should.exist(newFile.path);
        should.exist(newFile.relative);

        newFile.relative.should.equal('three/four/app.css'.split('/').join(path.sep));
        done();
      });

      fileInstance.path = '/some/project/src/one/two/three/four/app.css';
      stream.write(fileInstance);
    });

    it('should make no changes if the absolute depth option is greater than the tree depth', function (done) {
      var stream = flatten({includeParents: 8});
      stream.on('error', done);
      stream.on('data', function(newFile) {
        should.exist(newFile);
        should.exist(newFile.path);
        should.exist(newFile.relative);

        newFile.relative.should.equal('one/two/three/four/app.css'.split('/').join(path.sep));
        done();
      });

      fileInstance.path = '/some/project/src/one/two/three/four/app.css';
      stream.write(fileInstance);
    });
  });
});
