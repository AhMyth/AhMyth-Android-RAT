var should = require('should');
var path = require('path');
var flattenPath = require('../lib/flatten-path');
var fileInstance;

describe('gulp-flatten', function () {

  beforeEach(function () {
    fileInstance = {
      base: '/some/project/src/',
      path: '/some/project/src/top1/top2/bottom2/bottom1/app.css',
      relative: 'top1/top2/bottom2/bottom1/app.css'
    };
  });

  describe('flatten-path()', function () {
    it('should keep top parent dirs from indludeParents option', function (done) {
      var topOnly = flattenPath(fileInstance, {includeParents: 1});
      topOnly.should.equal('top1/app.css');

      done();
    });

    it('should keep bottom parent dirs from indludeParents option', function (done) {
      var bottomOnly = flattenPath(fileInstance, {includeParents: [0, 1]});
      bottomOnly.should.equal('bottom1/app.css');

      done();
    });

    it('should treat negative number in indludeParents as bottom parent levels', function (done) {
      var bottomOnly = flattenPath(fileInstance, {includeParents: -1});
      bottomOnly.should.equal('bottom1/app.css');

      done();
    });

    it('should keep top and bottom parent dirs from indludeParents option', function (done) {
      var both = flattenPath(fileInstance, {includeParents: [1, 2]});
      both.should.equal('top1/bottom2/bottom1/app.css');

      done();
    });

    it('should pick relative path if indludeParents bottom+top too long', function (done) {
      var relative = flattenPath(fileInstance, {includeParents: [10, 10]});
      relative.should.equal(fileInstance.relative);

      done();
    });
  });
});
