(function(){
    "use strict";
    var gutil = require('gulp-util'),
        through = require('through2'),
        rtlcss = require('rtlcss'),
        configLoader = require('rtlcss/lib/config-loader');

    module.exports = function (config) {
        return through.obj(function (file, enc, cb) {
            if (file.isNull()) {
                this.push(file);
                return cb();
            }

            if (file.isStream()) {
                this.emit('error', new gutil.PluginError('gulp-rtlcss', 'Streaming not supported'));
                return cb();
            }

            if (!config) {
                config = configLoader.load(null, file.cwd);
            }

            file.contents = new Buffer(rtlcss.configure(config).process(file.contents.toString()).css);
            this.push(file);
            cb();
        });
    };
})();
