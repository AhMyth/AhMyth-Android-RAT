var path           = require('path');
var accord         = require('accord');
var through2       = require('through2');
var gutil          = require('gulp-util');
var assign         = require('object-assign');
var applySourceMap = require('vinyl-sourcemaps-apply');

var PluginError    = gutil.PluginError;
var less           = accord.load('less');

module.exports = function (options) {
  // Mixes in default options.
  var opts = assign({}, {
      compress: false,
      paths: []
    }, options);

  return through2.obj(function(file, enc, cb) {
    if (file.isNull()) {
      return cb(null, file);
    }

    if (file.isStream()) {
      return cb(new PluginError('gulp-less', 'Streaming not supported'));
    }

    var str = file.contents.toString();

    // Injects the path of the current file
    opts.filename = file.path;

    // Bootstrap source maps
    if (file.sourceMap) {
      opts.sourcemap = true;
    }

    less.render(str, opts).then(function(res) {
      file.contents = new Buffer(res.result);
      file.path = gutil.replaceExtension(file.path, '.css');
      if (res.sourcemap) {
        res.sourcemap.file = file.relative;
        res.sourcemap.sources = res.sourcemap.sources.map(function (source) {
          return path.relative(file.base, source);
        });

        applySourceMap(file, res.sourcemap);
      }
      return file;
    }).then(function(file) {
      cb(null, file);
    }).catch(function(err) {
      // Convert the keys so PluginError can read them
      err.lineNumber = err.line;
      err.fileName = err.filename;

      // Add a better error message
      err.message = err.message + ' in file ' + err.fileName + ' line no. ' + err.lineNumber;
      return cb(new PluginError('gulp-less', err));
    });
  });
};
