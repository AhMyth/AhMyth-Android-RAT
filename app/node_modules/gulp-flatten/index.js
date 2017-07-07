var path = require('path');
var through2 = require('through2');
var flattenPath = require('./lib/flatten-path');
var PluginError = require('gulp-util').PluginError;

module.exports = function(opts) {
  opts = opts || {};
  opts.newPath = opts.newPath || '';

  return through2.obj(function(file, enc, next) {
    if (!file.isDirectory()) {
      try {
        file.path = path.join(file.base, opts.newPath, flattenPath(file, opts));
        this.push(file);
      } catch (e) {
        this.emit('error', new PluginError('gulp-flatten', e));
      }
    }
    next();
  });
};
