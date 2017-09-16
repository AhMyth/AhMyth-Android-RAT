var dedupe = require('../');
var should = require('should');
var through = require('through');
var path = require('path');
var File = require('gulp-util').File;
var Buffer = require('buffer').Buffer;
var fs = require('fs');
require('mocha');


describe('gulp-dedupe', function() {
    describe('dedupe()', function() {
        testDedupe(
            undefined,
            [
                'file1.txt', 'Contents1',
                'file1.txt', 'Contents1',
                'file2.txt', 'Contents2',
                'file1.txt', 'Contents1',
                'file2.txt', 'Contents2',
                'file3.txt', 'Contents3',
                'file4.txt', 'Contents4',
                'test/file1.txt', 'Contents1',
                'file4.txt', 'Contents4'
            ],
            [
                'file1.txt', 'Contents1',
                'file2.txt', 'Contents2',
                'file3.txt', 'Contents3',
                'file4.txt', 'Contents4',
                'test/file1.txt', 'Contents1'
            ]
        );

        testDedupe(
            {error: true},
            [
                'file1.txt', 'Contents1',
                'file1.txt', 'Contents1'
            ],
            [
                'file1.txt', 'Contents1', 'Duplicate `file1.txt`'
            ]
        );


        testDedupe(
            undefined,
            [
                'file1.txt', 'Contents1',
                'file1.txt', 'Contents2'
            ],
            [
                'file1.txt', 'Contents1', 'Duplicate file `file1.txt` with different contents'
            ]
        );

        testDedupe(
            {diff: true},
            [
                'file1.txt', 'Contents1',
                'file1.txt', 'Contents2'
            ],
            [
                'file1.txt', 'Contents1', 'Duplicate file `file1.txt` with different contents:\n'
            ]
        );

        testDedupe(
            {same: false},
            [
                'file1.txt', 'Contents1',
                'file1.txt', 'Contents2'
            ],
            [
                'file1.txt', 'Contents1'
            ]
        );

        function testDedupe(options, files, results) {
            var stream = dedupe(options);

            it('should dedupe files', function(done) {
                stream.on('data', function (file) {
                    var expectedFilename = results.shift(),
                        expectedHead = results.shift();
                    should.exist(file);
                    should.exist(file.relative);
                    should.exist(file.contents);
                    should.exist(expectedFilename);
                    should.exist(expectedHead);

                    var retFilename = path.resolve(file.path);
                    retFilename.should.equal(path.resolve(expectedFilename));
                    file.relative.should.equal(expectedFilename);

                    Buffer.isBuffer(file.contents).should.equal(true);
                    file.contents.toString().substring(0, expectedHead.length).should.equal(expectedHead);

                    if (results && !results.length) {
                        results = null;
                        done();
                    }
                });

                stream.on('error', function(err) {
                    var expected = results.shift();
                    var msg = (err.message || '').substring(0, expected.length);
                    msg.should.equal(expected);
                });

                while (files.length) {
                    stream.write(new File({
                        path: files.shift(),
                        contents: new Buffer(files.shift())
                    }));
                }

                stream.end();

                if (results && !results.length) {
                    results = null;
                    done();
                }
            });
        }
    });
});
