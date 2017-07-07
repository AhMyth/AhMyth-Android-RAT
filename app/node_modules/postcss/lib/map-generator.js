'use strict';

exports.__esModule = true;

var _jsBase = require('js-base64');

var _sourceMap = require('source-map');

var _sourceMap2 = _interopRequireDefault(_sourceMap);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var MapGenerator = function () {
    function MapGenerator(stringify, root, opts) {
        _classCallCheck(this, MapGenerator);

        this.stringify = stringify;
        this.mapOpts = opts.map || {};
        this.root = root;
        this.opts = opts;
    }

    MapGenerator.prototype.isMap = function isMap() {
        if (typeof this.opts.map !== 'undefined') {
            return !!this.opts.map;
        } else {
            return this.previous().length > 0;
        }
    };

    MapGenerator.prototype.previous = function previous() {
        var _this = this;

        if (!this.previousMaps) {
            this.previousMaps = [];
            this.root.walk(function (node) {
                if (node.source && node.source.input.map) {
                    var map = node.source.input.map;
                    if (_this.previousMaps.indexOf(map) === -1) {
                        _this.previousMaps.push(map);
                    }
                }
            });
        }

        return this.previousMaps;
    };

    MapGenerator.prototype.isInline = function isInline() {
        if (typeof this.mapOpts.inline !== 'undefined') {
            return this.mapOpts.inline;
        }

        var annotation = this.mapOpts.annotation;
        if (typeof annotation !== 'undefined' && annotation !== true) {
            return false;
        }

        if (this.previous().length) {
            return this.previous().some(function (i) {
                return i.inline;
            });
        } else {
            return true;
        }
    };

    MapGenerator.prototype.isSourcesContent = function isSourcesContent() {
        if (typeof this.mapOpts.sourcesContent !== 'undefined') {
            return this.mapOpts.sourcesContent;
        }
        if (this.previous().length) {
            return this.previous().some(function (i) {
                return i.withContent();
            });
        } else {
            return true;
        }
    };

    MapGenerator.prototype.clearAnnotation = function clearAnnotation() {
        if (this.mapOpts.annotation === false) return;

        var node = void 0;
        for (var i = this.root.nodes.length - 1; i >= 0; i--) {
            node = this.root.nodes[i];
            if (node.type !== 'comment') continue;
            if (node.text.indexOf('# sourceMappingURL=') === 0) {
                this.root.removeChild(i);
            }
        }
    };

    MapGenerator.prototype.setSourcesContent = function setSourcesContent() {
        var _this2 = this;

        var already = {};
        this.root.walk(function (node) {
            if (node.source) {
                var from = node.source.input.from;
                if (from && !already[from]) {
                    already[from] = true;
                    var relative = _this2.relative(from);
                    _this2.map.setSourceContent(relative, node.source.input.css);
                }
            }
        });
    };

    MapGenerator.prototype.applyPrevMaps = function applyPrevMaps() {
        for (var _iterator = this.previous(), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
            var _ref;

            if (_isArray) {
                if (_i >= _iterator.length) break;
                _ref = _iterator[_i++];
            } else {
                _i = _iterator.next();
                if (_i.done) break;
                _ref = _i.value;
            }

            var prev = _ref;

            var from = this.relative(prev.file);
            var root = prev.root || _path2.default.dirname(prev.file);
            var map = void 0;

            if (this.mapOpts.sourcesContent === false) {
                map = new _sourceMap2.default.SourceMapConsumer(prev.text);
                if (map.sourcesContent) {
                    map.sourcesContent = map.sourcesContent.map(function () {
                        return null;
                    });
                }
            } else {
                map = prev.consumer();
            }

            this.map.applySourceMap(map, from, this.relative(root));
        }
    };

    MapGenerator.prototype.isAnnotation = function isAnnotation() {
        if (this.isInline()) {
            return true;
        } else if (typeof this.mapOpts.annotation !== 'undefined') {
            return this.mapOpts.annotation;
        } else if (this.previous().length) {
            return this.previous().some(function (i) {
                return i.annotation;
            });
        } else {
            return true;
        }
    };

    MapGenerator.prototype.addAnnotation = function addAnnotation() {
        var content = void 0;

        if (this.isInline()) {
            content = 'data:application/json;base64,' + _jsBase.Base64.encode(this.map.toString());
        } else if (typeof this.mapOpts.annotation === 'string') {
            content = this.mapOpts.annotation;
        } else {
            content = this.outputFile() + '.map';
        }

        var eol = '\n';
        if (this.css.indexOf('\r\n') !== -1) eol = '\r\n';

        this.css += eol + '/*# sourceMappingURL=' + content + ' */';
    };

    MapGenerator.prototype.outputFile = function outputFile() {
        if (this.opts.to) {
            return this.relative(this.opts.to);
        } else if (this.opts.from) {
            return this.relative(this.opts.from);
        } else {
            return 'to.css';
        }
    };

    MapGenerator.prototype.generateMap = function generateMap() {
        this.generateString();
        if (this.isSourcesContent()) this.setSourcesContent();
        if (this.previous().length > 0) this.applyPrevMaps();
        if (this.isAnnotation()) this.addAnnotation();

        if (this.isInline()) {
            return [this.css];
        } else {
            return [this.css, this.map];
        }
    };

    MapGenerator.prototype.relative = function relative(file) {
        if (file.indexOf('<') === 0) return file;
        if (/^\w+:\/\//.test(file)) return file;

        var from = this.opts.to ? _path2.default.dirname(this.opts.to) : '.';

        if (typeof this.mapOpts.annotation === 'string') {
            from = _path2.default.dirname(_path2.default.resolve(from, this.mapOpts.annotation));
        }

        file = _path2.default.relative(from, file);
        if (_path2.default.sep === '\\') {
            return file.replace(/\\/g, '/');
        } else {
            return file;
        }
    };

    MapGenerator.prototype.sourcePath = function sourcePath(node) {
        if (this.mapOpts.from) {
            return this.mapOpts.from;
        } else {
            return this.relative(node.source.input.from);
        }
    };

    MapGenerator.prototype.generateString = function generateString() {
        var _this3 = this;

        this.css = '';
        this.map = new _sourceMap2.default.SourceMapGenerator({ file: this.outputFile() });

        var line = 1;
        var column = 1;

        var lines = void 0,
            last = void 0;
        this.stringify(this.root, function (str, node, type) {
            _this3.css += str;

            if (node && type !== 'end') {
                if (node.source && node.source.start) {
                    _this3.map.addMapping({
                        source: _this3.sourcePath(node),
                        generated: { line: line, column: column - 1 },
                        original: {
                            line: node.source.start.line,
                            column: node.source.start.column - 1
                        }
                    });
                } else {
                    _this3.map.addMapping({
                        source: '<no source>',
                        original: { line: 1, column: 0 },
                        generated: { line: line, column: column - 1 }
                    });
                }
            }

            lines = str.match(/\n/g);
            if (lines) {
                line += lines.length;
                last = str.lastIndexOf('\n');
                column = str.length - last;
            } else {
                column += str.length;
            }

            if (node && type !== 'start') {
                if (node.source && node.source.end) {
                    _this3.map.addMapping({
                        source: _this3.sourcePath(node),
                        generated: { line: line, column: column - 1 },
                        original: {
                            line: node.source.end.line,
                            column: node.source.end.column
                        }
                    });
                } else {
                    _this3.map.addMapping({
                        source: '<no source>',
                        original: { line: 1, column: 0 },
                        generated: { line: line, column: column - 1 }
                    });
                }
            }
        });
    };

    MapGenerator.prototype.generate = function generate() {
        this.clearAnnotation();

        if (this.isMap()) {
            return this.generateMap();
        } else {
            var result = '';
            this.stringify(this.root, function (i) {
                result += i;
            });
            return [result];
        }
    };

    return MapGenerator;
}();

exports.default = MapGenerator;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvbWFwLWdlbmVyYXRvci5lczYiXSwibmFtZXMiOlsiTWFwR2VuZXJhdG9yIiwic3RyaW5naWZ5Iiwicm9vdCIsIm9wdHMiLCJtYXBPcHRzIiwibWFwIiwiaXNNYXAiLCJwcmV2aW91cyIsImxlbmd0aCIsInByZXZpb3VzTWFwcyIsIndhbGsiLCJub2RlIiwic291cmNlIiwiaW5wdXQiLCJpbmRleE9mIiwicHVzaCIsImlzSW5saW5lIiwiaW5saW5lIiwiYW5ub3RhdGlvbiIsInNvbWUiLCJpIiwiaXNTb3VyY2VzQ29udGVudCIsInNvdXJjZXNDb250ZW50Iiwid2l0aENvbnRlbnQiLCJjbGVhckFubm90YXRpb24iLCJub2RlcyIsInR5cGUiLCJ0ZXh0IiwicmVtb3ZlQ2hpbGQiLCJzZXRTb3VyY2VzQ29udGVudCIsImFscmVhZHkiLCJmcm9tIiwicmVsYXRpdmUiLCJzZXRTb3VyY2VDb250ZW50IiwiY3NzIiwiYXBwbHlQcmV2TWFwcyIsInByZXYiLCJmaWxlIiwiZGlybmFtZSIsIlNvdXJjZU1hcENvbnN1bWVyIiwiY29uc3VtZXIiLCJhcHBseVNvdXJjZU1hcCIsImlzQW5ub3RhdGlvbiIsImFkZEFubm90YXRpb24iLCJjb250ZW50IiwiZW5jb2RlIiwidG9TdHJpbmciLCJvdXRwdXRGaWxlIiwiZW9sIiwidG8iLCJnZW5lcmF0ZU1hcCIsImdlbmVyYXRlU3RyaW5nIiwidGVzdCIsInJlc29sdmUiLCJzZXAiLCJyZXBsYWNlIiwic291cmNlUGF0aCIsIlNvdXJjZU1hcEdlbmVyYXRvciIsImxpbmUiLCJjb2x1bW4iLCJsaW5lcyIsImxhc3QiLCJzdHIiLCJzdGFydCIsImFkZE1hcHBpbmciLCJnZW5lcmF0ZWQiLCJvcmlnaW5hbCIsIm1hdGNoIiwibGFzdEluZGV4T2YiLCJlbmQiLCJnZW5lcmF0ZSIsInJlc3VsdCJdLCJtYXBwaW5ncyI6Ijs7OztBQUFBOztBQUNBOzs7O0FBQ0E7Ozs7Ozs7O0lBRXFCQSxZO0FBRWpCLDBCQUFZQyxTQUFaLEVB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S2YsS0FBS0MsTUFBTCxJQUFlRCxLQUFLQyxNQUFMLENBQVl5RCxHQUFoQyxFQUFzQztBQUNsQywyQkFBS2hFLEdBQUwsQ0FBUzJELFVBQVQsQ0FBb0I7QUFDaEJwRCxnQ0FBVyxPQUFLNEMsVUFBTCxDQUFnQjdDLElBQWhCLENBREs7QUFFaEJzRCxtQ0FBVyxFQUFFUCxVQUFGLEVBQVFDLFFBQVFBLFNBQVMsQ0FBekIsRUFGSztBQUdoQk8sa0NBQVc7QUFDUFIsa0NBQVEvQyxLQUFLQyxNQUFMLENBQVl5RCxHQUFaLENBQWdCWCxJQURqQjtBQUVQQyxvQ0FBUWhELEtBQUtDLE1BQUwsQ0FBWXlELEdBQVosQ0FBZ0JWO0FBRmpCO0FBSEsscUJBQXBCO0FBUUgsaUJBVEQsTUFTTztBQUNILDJCQUFLdEQsR0FBTCxDQUFTMkQsVUFBVCxDQUFvQjtBQUNoQnBELGdDQUFXLGFBREs7QUFFaEJzRCxrQ0FBVyxFQUFFUixNQUFNLENBQVIsRUFBV0MsUUFBUSxDQUFuQixFQUZLO0FBR2hCTSxtQ0FBVyxFQUFFUCxVQUFGLEVBQVFDLFFBQVFBLFNBQVMsQ0FBekI7QUFISyxxQkFBcEI7QUFLSDtBQUNKO0FBQ0osU0FqREQ7QUFrREgsSzs7MkJBRURXLFEsdUJBQVc7QUFDUCxhQUFLOUMsZUFBTDs7QUFFQSxZQUFLLEtBQUtsQixLQUFMLEVBQUwsRUFBb0I7QUFDaEIsbUJBQU8sS0FBSzRDLFdBQUwsRUFBUDtBQUNILFNBRkQsTUFFTztBQUNILGdCQUFJcUIsU0FBUyxFQUFiO0FBQ0EsaUJBQUt0RSxTQUFMLENBQWUsS0FBS0MsSUFBcEIsRUFBMEIsYUFBSztBQUMzQnFFLDBCQUFVbkQsQ0FBVjtBQUNILGFBRkQ7QUFHQSxtQkFBTyxDQUFDbUQsTUFBRCxDQUFQO0FBQ0g7QUFDSixLOzs7OztrQkFwUWdCdkUsWSIsImZpbGUiOiJtYXAtZ2VuZXJhdG9yLmpzIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IHsgQmFzZTY0IH0gZnJvbSAnanMtYmFzZTY0JztcbmltcG9ydCAgIG1vemlsbGEgIGZyb20gJ3NvdXJjZS1tYXAnO1xuaW1wb3J0ICAgcGF0aCAgICAgZnJvbSAncGF0aCc7XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIE1hcEdlbmVyYXRvciB7XG5cbiAgICBjb25zdHJ1Y3RvcihzdHJpbmdpZnksIHJvb3QsIG9wdHMpIHtcbiAgICAgICAgdGhpcy5zdHJpbmdpZnkgPSBzdHJpbmdpZnk7XG4gICAgICAgIHRoaXMubWFwT3B0cyAgID0gb3B0cy5tYXAgfHwgeyB9O1xuICAgICAgICB0aGlzLnJvb3QgICAgICA9IHJvb3Q7XG4gICAgICAgIHRoaXMub3B0cyAgICAgID0gb3B0cztcbiAgICB9XG5cbiAgICBpc01hcCgpIHtcbiAgICAgICAgaWYgKCB0eXBlb2YgdGhpcy5vcHRzLm1hcCAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICByZXR1cm4gISF0aGlzLm9wdHMubWFwO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMucHJldmlvdXMoKS5sZW5ndGggPiAwO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgcHJldmlvdXMoKSB7XG4gICAgICAgIGlmICggIXRoaXMucHJldmlvdXNNYXBzICkge1xuICAgICAgICAgICAgdGhpcy5wcmV2aW91c01hcHMgPSBbXTtcbiAgICAgICAgICAgIHRoaXMucm9vdC53YWxrKCBub2RlID0+IHtcbiAgICAgICAgICAgICAgICBpZiAoIG5vZGUuc291cmNlICYmIG5vZGUuc291cmNlLmlucHV0Lm1hcCApIHtcbiAgICAgICAgICAgICAgICAgICAgbGV0IG1hcCA9IG5vZGUuc291cmNlLmlucHV0Lm1hcDtcbiAgICAgICAgICAgICAgICAgICAgaWYgKCB0aGlzLnByZXZpb3VzTWFwcy5pbmRleE9mKG1hcCkgPT09IC0xICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgdGhpcy5wcmV2aW91c01hcHMucHVzaChtYXApO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfSk7XG4gICAgICAgIH1cblxuICAgICAgICByZXR1cm4gdGhpcy5wcmV2aW91c01hcHM7XG4gICAgfVxuXG4gICAgaXNJbmxpbmUoKSB7XG4gICAgICAgIGlmICggdHlwZW9mIHRoaXMubWFwT3B0cy5pbmxpbmUgIT09ICd1bmRlZmluZWQnICkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMubWFwT3B0cy5pbmxpbmU7XG4gICAgICAgIH1cblxuICAgICAgICBsZXQgYW5ub3RhdGlvbiA9IHRoaXMubWFwT3B0cy5hbm5vdGF0aW9uO1xuICAgICAgICBpZiAoIHR5cGVvZiBhbm5vdGF0aW9uICE9PSAndW5kZWZpbmVkJyAmJiBhbm5vdGF0aW9uICE9PSB0cnVlICkge1xuICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKCB0aGlzLnByZXZpb3VzKCkubGVuZ3RoICkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMucHJldmlvdXMoKS5zb21lKCBpID0+IGkuaW5saW5lICk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICByZXR1cm4gdHJ1ZTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIGlzU291cmNlc0NvbnRlbnQoKSB7XG4gICAgICAgIGlmICggdHlwZW9mIHRoaXMubWFwT3B0cy5zb3VyY2VzQ29udGVudCAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5tYXBPcHRzLnNvdXJjZXNDb250ZW50O1xuICAgICAgICB9XG4gICAgICAgIGlmICggdGhpcy5wcmV2aW91cygpLmxlbmd0aCApIHtcbiAgICAgICAgICAgIHJldHVybiB0aGlzLnByZXZpb3VzKCkuc29tZSggaSA9PiBpLndpdGhDb250ZW50KCkgKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiB0cnVlO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgY2xlYXJBbm5vdGF0aW9uKCkge1xuICAgICAgICBpZiAoIHRoaXMubWFwT3B0cy5hbm5vdGF0aW9uID09PSBmYWxzZSApIHJldHVybjtcblxuICAgICAgICBsZXQgbm9kZTtcbiAgICAgICAgZm9yICggbGV0IGkgPSB0aGlzLnJvb3Qubm9kZXMubGVuZ3RoIC0gMTsgaSA+PSAwOyBpLS0gKSB7XG4gICAgICAgICAgICBub2RlID0gdGhpcy5yb290Lm5vZGVzW2ldO1xuICAgICAgICAgICAgaWYgKCBub2RlLnR5cGUgIT09ICdjb21tZW50JyApIGNvbnRpbnVlO1xuICAgICAgICAgICAgaWYgKCBub2RlLnRleHQuaW5kZXhPZignIyBzb3VyY2VNYXBwaW5nVVJMPScpID09PSAwICkge1xuICAgICAgICAgICAgICAgIHRoaXMucm9vdC5yZW1vdmVDaGlsZChpKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgIH1cblxuICAgIHNldFNvdXJjZXNDb250ZW50KCkge1xuICAgICAgICBsZXQgYWxyZWFkeSA9IHsgfTtcbiAgICAgICAgdGhpcy5yb290LndhbGsoIG5vZGUgPT4ge1xuICAgICAgICAgICAgaWYgKCBub2RlLnNvdXJjZSApIHtcbiAgICAgICAgICAgICAgICBsZXQgZnJvbSA9IG5vZGUuc291cmNlLmlucHV0LmZyb207XG4gICAgICAgICAgICAgICAgaWYgKCBmcm9tICYmICFhbHJlYWR5W2Zyb21dICkge1xuICAgICAgICAgICAgICAgICAgICBhbHJlYWR5W2Zyb21dID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICAgICAgbGV0IHJlbGF0aXZlID0gdGhpcy5yZWxhdGl2ZShmcm9tKTtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5tYXAuc2V0U291cmNlQ29udGVudChyZWxhdGl2ZSwgbm9kZS5zb3VyY2UuaW5wdXQuY3NzKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG4gICAgICAgIH0pO1xuICAgIH1cblxuICAgIGFwcGx5UHJldk1hcHMoKSB7XG4gICAgICAgIGZvciAoIGxldCBwcmV2IG9mIHRoaXMucHJldmlvdXMoKSApIHtcbiAgICAgICAgICAgIGxldCBmcm9tID0gdGhpcy5yZWxhdGl2ZShwcmV2LmZpbGUpO1xuICAgICAgICAgICAgbGV0IHJvb3QgPSBwcmV2LnJvb3QgfHwgcGF0aC5kaXJuYW1lKHByZXYuZmlsZSk7XG4gICAgICAgICAgICBsZXQgbWFwO1xuXG4gICAgICAgICAgICBpZiAoIHRoaXMubWFwT3B0cy5zb3VyY2VzQ29udGVudCA9PT0gZmFsc2UgKSB7XG4gICAgICAgICAgICAgICAgbWFwID0gbmV3IG1vemlsbGEuU291cmNlTWFwQ29uc3VtZXIocHJldi50ZXh0KTtcbiAgICAgICAgICAgICAgICBpZiAoIG1hcC5zb3VyY2VzQ29udGVudCApIHtcbiAgICAgICAgICAgICAgICAgICAgbWFwLnNvdXJjZXNDb250ZW50ID0gbWFwLnNvdXJjZXNDb250ZW50Lm1hcCggKCkgPT4gbnVsbCApO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgbWFwID0gcHJldi5jb25zdW1lcigpO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICB0aGlzLm1hcC5hcHBseVNvdXJjZU1hcChtYXAsIGZyb20sIHRoaXMucmVsYXRpdmUocm9vdCkpO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgaXNBbm5vdGF0aW9uKCkge1xuICAgICAgICBpZiAoIHRoaXMuaXNJbmxpbmUoKSApIHtcbiAgICAgICAgICAgIHJldHVybiB0cnVlO1xuICAgICAgICB9IGVsc2UgaWYgKCB0eXBlb2YgdGhpcy5tYXBPcHRzLmFubm90YXRpb24gIT09ICd1bmRlZmluZWQnICkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMubWFwT3B0cy5hbm5vdGF0aW9uO1xuICAgICAgICB9IGVsc2UgaWYgKCB0aGlzLnByZXZpb3VzKCkubGVuZ3RoICkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMucHJldmlvdXMoKS5zb21lKCBpID0+IGkuYW5ub3RhdGlvbiApO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgcmV0dXJuIHRydWU7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBhZGRBbm5vdGF0aW9uKCkge1xuICAgICAgICBsZXQgY29udGVudDtcblxuICAgICAgICBpZiAoIHRoaXMuaXNJbmxpbmUoKSApIHtcbiAgICAgICAgICAgIGNvbnRlbnQgPSAnZGF0YTphcHBsaWNhdGlvbi9qc29uO2Jhc2U2NCwnICtcbiAgICAgICAgICAgICAgICAgICAgICAgQmFzZTY0LmVuY29kZSggdGhpcy5tYXAudG9TdHJpbmcoKSApO1xuXG4gICAgICAgIH0gZWxzZSBpZiAoIHR5cGVvZiB0aGlzLm1hcE9wdHMuYW5ub3RhdGlvbiA9PT0gJ3N0cmluZycgKSB7XG4gICAgICAgICAgICBjb250ZW50ID0gdGhpcy5tYXBPcHRzLmFubm90YXRpb247XG5cbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIGNvbnRlbnQgPSB0aGlzLm91dHB1dEZpbGUoKSArICcubWFwJztcbiAgICAgICAgfVxuXG4gICAgICAgIGxldCBlb2wgICA9ICdcXG4nO1xuICAgICAgICBpZiAoIHRoaXMuY3NzLmluZGV4T2YoJ1xcclxcbicpICE9PSAtMSApIGVvbCA9ICdcXHJcXG4nO1xuXG4gICAgICAgIHRoaXMuY3NzICs9IGVvbCArICcvKiMgc291cmNlTWFwcGluZ1VSTD0nICsgY29udGVudCArICcgKi8nO1xuICAgIH1cblxuICAgIG91dHB1dEZpbGUoKSB7XG4gICAgICAgIGlmICggdGhpcy5vcHRzLnRvICkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMucmVsYXRpdmUodGhpcy5vcHRzLnRvKTtcbiAgICAgICAgfSBlbHNlIGlmICggdGhpcy5vcHRzLmZyb20gKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5yZWxhdGl2ZSh0aGlzLm9wdHMuZnJvbSk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICByZXR1cm4gJ3RvLmNzcyc7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBnZW5lcmF0ZU1hcCgpIHtcbiAgICAgICAgdGhpcy5nZW5lcmF0ZVN0cmluZygpO1xuICAgICAgICBpZiAoIHRoaXMuaXNTb3VyY2VzQ29udGVudCgpICkgICAgdGhpcy5zZXRTb3VyY2VzQ29udGVudCgpO1xuICAgICAgICBpZiAoIHRoaXMucHJldmlvdXMoKS5sZW5ndGggPiAwICkgdGhpcy5hcHBseVByZXZNYXBzKCk7XG4gICAgICAgIGlmICggdGhpcy5pc0Fubm90YXRpb24oKSApICAgICAgICB0aGlzLmFkZEFubm90YXRpb24oKTtcblxuICAgICAgICBpZiAoIHRoaXMuaXNJbmxpbmUoKSApIHtcbiAgICAgICAgICAgIHJldHVybiBbdGhpcy5jc3NdO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgcmV0dXJuIFt0aGlzLmNzcywgdGhpcy5tYXBdO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgcmVsYXRpdmUoZmlsZSkge1xuICAgICAgICBpZiAoIGZpbGUuaW5kZXhPZignPCcpID09PSAwICkgcmV0dXJuIGZpbGU7XG4gICAgICAgIGlmICggL15cXHcrOlxcL1xcLy8udGVzdChmaWxlKSApIHJldHVybiBmaWxlO1xuXG4gICAgICAgIGxldCBmcm9tID0gdGhpcy5vcHRzLnRvID8gcGF0aC5kaXJuYW1lKHRoaXMub3B0cy50bykgOiAnLic7XG5cbiAgICAgICAgaWYgKCB0eXBlb2YgdGhpcy5tYXBPcHRzLmFubm90YXRpb24gPT09ICdzdHJpbmcnICkge1xuICAgICAgICAgICAgZnJvbSA9IHBhdGguZGlybmFtZSggcGF0aC5yZXNvbHZlKGZyb20sIHRoaXMubWFwT3B0cy5hbm5vdGF0aW9uKSApO1xuICAgICAgICB9XG5cbiAgICAgICAgZmlsZSA9IHBhdGgucmVsYXRpdmUoZnJvbSwgZmlsZSk7XG4gICAgICAgIGlmICggcGF0aC5zZXAgPT09ICdcXFxcJyApIHtcbiAgICAgICAgICAgIHJldHVybiBmaWxlLnJlcGxhY2UoL1xcXFwvZywgJy8nKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiBmaWxlO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgc291cmNlUGF0aChub2RlKSB7XG4gICAgICAgIGlmICggdGhpcy5tYXBPcHRzLmZyb20gKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5tYXBPcHRzLmZyb207XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5yZWxhdGl2ZShub2RlLnNvdXJjZS5pbnB1dC5mcm9tKTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIGdlbmVyYXRlU3RyaW5nKCkge1xuICAgICAgICB0aGlzLmNzcyA9ICcnO1xuICAgICAgICB0aGlzLm1hcCA9IG5ldyBtb3ppbGxhLlNvdXJjZU1hcEdlbmVyYXRvcih7IGZpbGU6IHRoaXMub3V0cHV0RmlsZSgpIH0pO1xuXG4gICAgICAgIGxldCBsaW5lICAgPSAxO1xuICAgICAgICBsZXQgY29sdW1uID0gMTtcblxuICAgICAgICBsZXQgbGluZXMsIGxhc3Q7XG4gICAgICAgIHRoaXMuc3RyaW5naWZ5KHRoaXMucm9vdCwgKHN0ciwgbm9kZSwgdHlwZSkgPT4ge1xuICAgICAgICAgICAgdGhpcy5jc3MgKz0gc3RyO1xuXG4gICAgICAgICAgICBpZiAoIG5vZGUgJiYgdHlwZSAhPT0gJ2VuZCcgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCBub2RlLnNvdXJjZSAmJiBub2RlLnNvdXJjZS5zdGFydCApIHtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5tYXAuYWRkTWFwcGluZyh7XG4gICAgICAgICAgICAgICAgICAgICAgICBzb3VyY2U6ICAgIHRoaXMuc291cmNlUGF0aChub2RlKSxcbiAgICAgICAgICAgICAgICAgICAgICAgIGdlbmVyYXRlZDogeyBsaW5lLCBjb2x1bW46IGNvbHVtbiAtIDEgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgIG9yaWdpbmFsOiAge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmU6ICAgbm9kZS5zb3VyY2Uuc3RhcnQubGluZSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb2x1bW46IG5vZGUuc291cmNlLnN0YXJ0LmNvbHVtbiAtIDFcbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5tYXAuYWRkTWFwcGluZyh7XG4gICAgICAgICAgICAgICAgICAgICAgICBzb3VyY2U6ICAgICc8bm8gc291cmNlPicsXG4gICAgICAgICAgICAgICAgICAgICAgICBvcmlnaW5hbDogIHsgbGluZTogMSwgY29sdW1uOiAwIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICBnZW5lcmF0ZWQ6IHsgbGluZSwgY29sdW1uOiBjb2x1bW4gLSAxIH1cbiAgICAgICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICBsaW5lcyA9IHN0ci5tYXRjaCgvXFxuL2cpO1xuICAgICAgICAgICAgaWYgKCBsaW5lcyApIHtcbiAgICAgICAgICAgICAgICBsaW5lICArPSBsaW5lcy5sZW5ndGg7XG4gICAgICAgICAgICAgICAgbGFzdCAgID0gc3RyLmxhc3RJbmRleE9mKCdcXG4nKTtcbiAgICAgICAgICAgICAgICBjb2x1bW4gPSBzdHIubGVuZ3RoIC0gbGFzdDtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgY29sdW1uICs9IHN0ci5sZW5ndGg7XG4gICAgICAgICAgICB9XG5cbiAgICAgICAgICAgIGlmICggbm9kZSAmJiB0eXBlICE9PSAnc3RhcnQnICkge1xuICAgICAgICAgICAgICAgIGlmICggbm9kZS5zb3VyY2UgJiYgbm9kZS5zb3VyY2UuZW5kICkge1xuICAgICAgICAgICAgICAgICAgICB0aGlzLm1hcC5hZGRNYXBwaW5nKHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHNvdXJjZTogICAgdGhpcy5zb3VyY2VQYXRoKG5vZGUpLFxuICAgICAgICAgICAgICAgICAgICAgICAgZ2VuZXJhdGVkOiB7IGxpbmUsIGNvbHVtbjogY29sdW1uIC0gMSB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgb3JpZ2luYWw6ICB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgbGluZTogICBub2RlLnNvdXJjZS5lbmQubGluZSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb2x1bW46IG5vZGUuc291cmNlLmVuZC5jb2x1bW5cbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5tYXAuYWRkTWFwcGluZyh7XG4gICAgICAgICAgICAgICAgICAgICAgICBzb3VyY2U6ICAgICc8bm8gc291cmNlPicsXG4gICAgICAgICAgICAgICAgICAgICAgICBvcmlnaW5hbDogIHsgbGluZTogMSwgY29sdW1uOiAwIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICBnZW5lcmF0ZWQ6IHsgbGluZSwgY29sdW1uOiBjb2x1bW4gLSAxIH1cbiAgICAgICAgICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9KTtcbiAgICB9XG5cbiAgICBnZW5lcmF0ZSgpIHtcbiAgICAgICAgdGhpcy5jbGVhckFubm90YXRpb24oKTtcblxuICAgICAgICBpZiAoIHRoaXMuaXNNYXAoKSApIHtcbiAgICAgICAgICAgIHJldHVybiB0aGlzLmdlbmVyYXRlTWFwKCk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICBsZXQgcmVzdWx0ID0gJyc7XG4gICAgICAgICAgICB0aGlzLnN0cmluZ2lmeSh0aGlzLnJvb3QsIGkgPT4ge1xuICAgICAgICAgICAgICAgIHJlc3VsdCArPSBpO1xuICAgICAgICAgICAgfSk7XG4gICAgICAgICAgICByZXR1cm4gW3Jlc3VsdF07XG4gICAgICAgIH1cbiAgICB9XG5cbn1cbiJdfQ==
