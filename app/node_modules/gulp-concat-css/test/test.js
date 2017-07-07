var expect = require('chai').expect,
  through = require('through2'),
  gutil = require('gulp-util'),
  fs = require('fs'),
  path = require('path'),
  concatCss = require('../');


function expected(file) {
  var base = path.join(process.cwd(), 'test/expected');
  var filepath = path.resolve(base, file);
  return new gutil.File({
    path: filepath,
    cwd: process.cwd(),
    base: base,
    contents: fs.readFileSync(filepath)
  });
}

function fixture(file) {
  var base = path.join(process.cwd(), 'test/fixtures');
  var filepath = path.join(base, file);
  return new gutil.File({
    path: filepath,
    cwd: process.cwd(),
    base: base,
    contents: fs.readFileSync(filepath)
  });
}

describe('gulp-concat-css', function() {
  it('should only bubble up imports', function(done) {
    var now = Date.now();
    var stream = concatCss('build/bundle-bubbleonly.css', {inlineImports: false, rebaseUrls: false});
    var expectedFile = expected('build/bundle-bubbleonly.css');
    stream
      .pipe(through.obj(function(file, enc, cb) {
        //fs.writeFileSync("bundle.css", file.contents);

        expect(String(file.contents)).to.be.equal(String(expectedFile.contents));
        expect(path.basename(file.path)).to.be.equal(path.basename(expectedFile.path));
        expect(file.cwd, "cwd").to.be.equal(expectedFile.cwd);
        expect(file.relative, "relative").to.be.equal(expectedFile.relative);
        console.log('Execution time: ' + (Date.now() - now) + 'ms');
        done();
      }));

    stream.write(fixture('main.css'));
    stream.write(fixture('vendor/vendor.css'));
    stream.end();
  });

  it('should only rebase urls', function(done) {
    var now = Date.now();
    var stream = concatCss('build/bundle-rebase.css', {inlineImports: false});
    var expectedFile = expected('build/bundle-rebase.css');
    stream
      .pipe(through.obj(function(file, enc, cb) {
        //fs.writeFileSync("bundle.css", file.contents);

        expect(String(file.contents)).to.be.equal(String(expectedFile.contents));
        expect(path.basename(file.path)).to.be.equal(path.basename(expectedFile.path));
        expect(file.cwd, "cwd").to.be.equal(expectedFile.cwd);
        expect(file.relative, "relative").to.be.equal(expectedFile.relative);
        console.log('Execution time: ' + (Date.now() - now) + 'ms');
        done();
      }));

    stream.write(fixture('main.css'));
    stream.write(fixture('vendor/vendor.css'));
    stream.end();
  });


  it('should only inline imports', function(done) {
    var now = Date.now();
    var stream = concatCss('build/bundle-import.css', {inlineImports: true, rebaseUrls: false});
    var expectedFile = expected('build/bundle-import.css');
    stream
      .pipe(through.obj(function(file, enc, cb) {
        //fs.writeFileSync("bundle.css", file.contents);

        expect(String(file.contents)).to.be.equal(String(expectedFile.contents));
        expect(path.basename(file.path)).to.be.equal(path.basename(expectedFile.path));
        expect(file.cwd, "cwd").to.be.equal(expectedFile.cwd);
        expect(file.relative, "relative").to.be.equal(expectedFile.relative);
        console.log('Execution time: ' + (Date.now() - now) + 'ms');
        done();
      }));

    stream.write(fixture('main.css'));
    stream.write(fixture('vendor/vendor.css'));
    stream.end();
  });

  it('should concat, rebase urls, inline imports and bubble up external imports', function(done) {
    var now = Date.now();
    var stream = concatCss('build/bundle-all.css');
    var expectedFile = expected('build/bundle-all.css');
    stream
      .pipe(through.obj(function(file, enc, cb) {
        //fs.writeFileSync("bundle.css", file.contents);
        expect(String(file.contents)).to.be.equal(String(expectedFile.contents));
        expect(path.basename(file.path)).to.be.equal(path.basename(expectedFile.path));
        expect(file.cwd, "cwd").to.be.equal(expectedFile.cwd);
        expect(file.relative, "relative").to.be.equal(expectedFile.relative);
        console.log('Execution time: ' + (Date.now() - now) + 'ms');
        done();
      }));

    stream.write(fixture('main.css'));
    stream.write(fixture('vendor/vendor.css'));
    stream.end();
  });

  it('should not crash if no file is provided', function(done) {
    var stream = concatCss('build/bundle-all.css');
    stream
      .on('error', function() {
        done(false);
      })
      .pipe(through.obj(function(file, enc, cb) {
        done(false);
      }, function() {
        done();
      }));

    stream.end();
  });
});
