(function() {
    'use strict';
    var assert = require('assert');
    var gutil = require('gulp-util');
    var gulpRtlcss = require('./index');

    it('should convert LTR CSS to RTL', function (cb) {
        var stream = gulpRtlcss();

        stream.on('data', function (file) {
            assert.equal(file.contents.toString(), '.selector { float: right; /* comment */ }');
            cb();
        });

        stream.write(new gutil.File({
            path: 'styles.css',
            contents: new Buffer('.selector { float: left; /* comment */ }')
        }));
    });

    it('should accept rtlcss configuration', function (cb) {
        var stream = gulpRtlcss({
            "options": {
                "preserveComments": true,
                "preserveDirectives": false,
                "swapLeftRightInUrl": true,
                "swapLtrRtlInUrl": true,
                "swapWestEastInUrl": true,
                "autoRename": false,
                "greedy": false,
                "enableLogging": false,
                "minify": false
            },
            "rules": [ ],
            "declarations": [ ],
            "properties": [ ],
            "map": false
        });

        stream.on('data', function (file) {
            assert.equal(file.contents.toString(), ".pull-left {content: ' ';}");
            cb();
        });

        stream.write(new gutil.File({
            path: 'styles.css',
            contents: new Buffer(".pull-left {content: ' ';}")
        }));
    });
})();
