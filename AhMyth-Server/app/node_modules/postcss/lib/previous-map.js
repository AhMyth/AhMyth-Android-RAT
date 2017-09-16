'use strict';

exports.__esModule = true;

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

var _jsBase = require('js-base64');

var _sourceMap = require('source-map');

var _sourceMap2 = _interopRequireDefault(_sourceMap);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

/**
 * Source map information from input CSS.
 * For example, source map after Sass compiler.
 *
 * This class will automatically find source map in input CSS or in file system
 * near input file (according `from` option).
 *
 * @example
 * const root = postcss.parse(css, { from: 'a.sass.css' });
 * root.input.map //=> PreviousMap
 */
var PreviousMap = function () {

    /**
     * @param {string}         css    - input CSS source
     * @param {processOptions} [opts] - {@link Processor#process} options
     */
    function PreviousMap(css, opts) {
        _classCallCheck(this, PreviousMap);

        this.loadAnnotation(css);
        /**
         * @member {boolean} - Was source map inlined by data-uri to input CSS.
         */
        this.inline = this.startWith(this.annotation, 'data:');

        var prev = opts.map ? opts.map.prev : undefined;
        var text = this.loadMap(opts.from, prev);
        if (text) this.text = text;
    }

    /**
     * Create a instance of `SourceMapGenerator` class
     * from the `source-map` library to work with source map information.
     *
     * It is lazy method, so it will create object only on first call
     * and then it will use cache.
     *
     * @return {SourceMapGenerator} object with source map information
     */


    PreviousMap.prototype.consumer = function consumer() {
        if (!this.consumerCache) {
            this.consumerCache = new _sourceMap2.default.SourceMapConsumer(this.text);
        }
        return this.consumerCache;
    };

    /**
     * Does source map contains `sourcesContent` with input source text.
     *
     * @return {boolean} Is `sourcesContent` present
     */


    PreviousMap.prototype.withContent = function withContent() {
        return !!(this.consumer().sourcesContent && this.consumer().sourcesContent.length > 0);
    };

    PreviousMap.prototype.startWith = function startWith(string, start) {
        if (!string) return false;
        return string.substr(0, start.length) === start;
    };

    PreviousMap.prototype.loadAnnotation = function loadAnnotation(css) {
        var match = css.match(/\/\*\s*# sourceMappingURL=(.*)\s*\*\//);
        if (match) this.annotation = match[1].trim();
    };

    PreviousMap.prototype.decodeInline = function decodeInline(text) {
        var utfd64 = 'data:application/json;charset=utf-8;base64,';
        var utf64 = 'data:application/json;charset=utf8;base64,';
        var b64 = 'data:application/json;base64,';
        var uri = 'data:application/json,';

        if (this.startWith(text, uri)) {
            return decodeURIComponent(text.substr(uri.length));
        } else if (this.startWith(text, b64)) {
            return _jsBase.Base64.decode(text.substr(b64.length));
        } else if (this.startWith(text, utf64)) {
            return _jsBase.Base64.decode(text.substr(utf64.length));
        } else if (this.startWith(text, utfd64)) {
            return _jsBase.Base64.decode(text.substr(utfd64.length));
        } else {
            var encoding = text.match(/data:application\/json;([^,]+),/)[1];
            throw new Error('Unsupported source map encoding ' + encoding);
        }
    };

    PreviousMap.prototype.loadMap = function loadMap(file, prev) {
        if (prev === false) return false;

        if (prev) {
            if (typeof prev === 'string') {
                return prev;
            } else if (typeof prev === 'function') {
                var prevPath = prev(file);
                if (prevPath && _fs2.default.existsSync && _fs2.default.existsSync(prevPath)) {
                    return _fs2.default.readFileSync(prevPath, 'utf-8').toString().trim();
                } else {
                    throw new Error('Unable to load previous source map: ' + prevPath.toString());
                }
            } else if (prev instanceof _sourceMap2.default.SourceMapConsumer) {
                return _sourceMap2.default.SourceMapGenerator.fromSourceMap(prev).toString();
            } else if (prev instanceof _sourceMap2.default.SourceMapGenerator) {
                return prev.toString();
            } else if (this.isMap(prev)) {
                return JSON.stringify(prev);
            } else {
                throw new Error('Unsupported previous source map format: ' + prev.toString());
            }
        } else if (this.inline) {
            return this.decodeInline(this.annotation);
        } else if (this.annotation) {
            var map = this.annotation;
            if (file) map = _path2.default.join(_path2.default.dirname(file), map);

            this.root = _path2.default.dirname(map);
            if (_fs2.default.existsSync && _fs2.default.existsSync(map)) {
                return _fs2.default.readFileSync(map, 'utf-8').toString().trim();
            } else {
                return false;
            }
        }
    };

    PreviousMap.prototype.isMap = function isMap(map) {
        if ((typeof map === 'undefined' ? 'undefined' : _typeof(map)) !== 'object') return false;
        return typeof map.mappings === 'string' || typeof map._mappings === 'string';
    };

    return PreviousMap;
}();

exports.default = PreviousMap;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvcHJldmlvdXMtbWFwLmVzNiJdLCJuYW1lcyI6WyJQcmV2aW91c01hcCIsImNzcyIsIm9wdHMiLCJsb2FkQW5ub3RhdGlvbiIsImlubGluZSIsInN0YXJ0V2l0aCIsImFubm90YXRpb24iLCJwcmV2IiwibWFwIiwidW5kZWZpbmVkIiwidGV4dCIsImxvYWRNYXAiLCJmcm9tIiwiY29uc3VtZXIiLCJjb25zdW1lckNhY2hlIiwiU291cmNlTWFwQ29uc3VtZXIiLCJ3aXRoQ29udGVudCIsInNvdXJjZXNDb250ZW50IiwibGVuZ3RoIiwic3RyaW5nIiwic3RhcnQiLCJzdWJzdHIiLCJtYXRjaCIsInRyaW0iLCJkZWNvZGVJbmxpbmUiLCJ1dGZkNjQiLCJ1dGY2NCIsImI2NCIsInVyaSIsImRlY29kZVVSSUNvbXBvbmVudCIsImRlY29kZSIsImVuY29kaW5nIiwiRXJyb3IiLCJmaWxlIiwicHJldlBhdGgiLCJleGlzdHNTeW5jIiwicmVhZEZpbGVTeW5jIiwidG9TdHJpbmciLCJTb3VyY2VNYXBHZW5lcmF0b3IiLCJmcm9tU291cmNlTWFwIiwiaXNNYXAiLCJKU09OIiwic3RyaW5naWZ5Iiwiam9pbiIsImRpcm5hbWUiLCJyb290IiwibWFwcGluZ3MiLCJfbWFwcGluZ3MiXSwibWFwcGluZ3MiOiI7Ozs7OztBQUFBOztBQUNBOzs7O0FBQ0E7Ozs7QUFDQTs7Ozs7Ozs7QUFFQTs7Ozs7Ozs7Ozs7SUFXTUEsVzs7QUFFRjs7OztBQUlBLHlCQUFZQyxHQUFaLEVBQWlCQyxJQUFqQixFQUF1QjtBQUFBOztBQUNuQixhQUFLQyxjQUFMLENBQW9CRixHQUFwQjtBQUNBOzs7QUFHQSxhQUFLRyxNQUFMLEdBQWMsS0FBS0MsU0FBTCxDQUFlLEtBQUtDLFVBQXBCLEVBQWdDLE9BQWhDLENBQWQ7O0FBRUEsWUFBSUMsT0FBT0wsS0FBS00sR0FBTCxHQUFXTixLQUFLTSxHQUFMLENBQVNELElBQXBCLEdBQTJCRSxTQUF0QztBQUNBLFlBQUlDLE9BQU8sS0FBS0MsT0FB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NkIsUUFBOUIsR0FBeUNkLElBQXpDLEVBQVA7QUFDSCxhQUZELE1BRU87QUFDSCx1QkFBTyxLQUFQO0FBQ0g7QUFDSjtBQUNKLEs7OzBCQUVEaUIsSyxrQkFBTWhDLEcsRUFBSztBQUNQLFlBQUssUUFBT0EsR0FBUCx5Q0FBT0EsR0FBUCxPQUFlLFFBQXBCLEVBQStCLE9BQU8sS0FBUDtBQUMvQixlQUFPLE9BQU9BLElBQUlzQyxRQUFYLEtBQXdCLFFBQXhCLElBQ0EsT0FBT3RDLElBQUl1QyxTQUFYLEtBQXlCLFFBRGhDO0FBRUgsSzs7Ozs7a0JBR1UvQyxXIiwiZmlsZSI6InByZXZpb3VzLW1hcC5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7IEJhc2U2NCB9IGZyb20gJ2pzLWJhc2U2NCc7XG5pbXBvcnQgICBtb3ppbGxhICBmcm9tICdzb3VyY2UtbWFwJztcbmltcG9ydCAgIHBhdGggICAgIGZyb20gJ3BhdGgnO1xuaW1wb3J0ICAgZnMgICAgICAgZnJvbSAnZnMnO1xuXG4vKipcbiAqIFNvdXJjZSBtYXAgaW5mb3JtYXRpb24gZnJvbSBpbnB1dCBDU1MuXG4gKiBGb3IgZXhhbXBsZSwgc291cmNlIG1hcCBhZnRlciBTYXNzIGNvbXBpbGVyLlxuICpcbiAqIFRoaXMgY2xhc3Mgd2lsbCBhdXRvbWF0aWNhbGx5IGZpbmQgc291cmNlIG1hcCBpbiBpbnB1dCBDU1Mgb3IgaW4gZmlsZSBzeXN0ZW1cbiAqIG5lYXIgaW5wdXQgZmlsZSAoYWNjb3JkaW5nIGBmcm9tYCBvcHRpb24pLlxuICpcbiAqIEBleGFtcGxlXG4gKiBjb25zdCByb290ID0gcG9zdGNzcy5wYXJzZShjc3MsIHsgZnJvbTogJ2Euc2Fzcy5jc3MnIH0pO1xuICogcm9vdC5pbnB1dC5tYXAgLy89PiBQcmV2aW91c01hcFxuICovXG5jbGFzcyBQcmV2aW91c01hcCB7XG5cbiAgICAvKipcbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gICAgICAgICBjc3MgICAgLSBpbnB1dCBDU1Mgc291cmNlXG4gICAgICogQHBhcmFtIHtwcm9jZXNzT3B0aW9uc30gW29wdHNdIC0ge0BsaW5rIFByb2Nlc3NvciNwcm9jZXNzfSBvcHRpb25zXG4gICAgICovXG4gICAgY29uc3RydWN0b3IoY3NzLCBvcHRzKSB7XG4gICAgICAgIHRoaXMubG9hZEFubm90YXRpb24oY3NzKTtcbiAgICAgICAgLyoqXG4gICAgICAgICAqIEBtZW1iZXIge2Jvb2xlYW59IC0gV2FzIHNvdXJjZSBtYXAgaW5saW5lZCBieSBkYXRhLXVyaSB0byBpbnB1dCBDU1MuXG4gICAgICAgICAqL1xuICAgICAgICB0aGlzLmlubGluZSA9IHRoaXMuc3RhcnRXaXRoKHRoaXMuYW5ub3RhdGlvbiwgJ2RhdGE6Jyk7XG5cbiAgICAgICAgbGV0IHByZXYgPSBvcHRzLm1hcCA/IG9wdHMubWFwLnByZXYgOiB1bmRlZmluZWQ7XG4gICAgICAgIGxldCB0ZXh0ID0gdGhpcy5sb2FkTWFwKG9wdHMuZnJvbSwgcHJldik7XG4gICAgICAgIGlmICggdGV4dCApIHRoaXMudGV4dCA9IHRleHQ7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogQ3JlYXRlIGEgaW5zdGFuY2Ugb2YgYFNvdXJjZU1hcEdlbmVyYXRvcmAgY2xhc3NcbiAgICAgKiBmcm9tIHRoZSBgc291cmNlLW1hcGAgbGlicmFyeSB0byB3b3JrIHdpdGggc291cmNlIG1hcCBpbmZvcm1hdGlvbi5cbiAgICAgKlxuICAgICAqIEl0IGlzIGxhenkgbWV0aG9kLCBzbyBpdCB3aWxsIGNyZWF0ZSBvYmplY3Qgb25seSBvbiBmaXJzdCBjYWxsXG4gICAgICogYW5kIHRoZW4gaXQgd2lsbCB1c2UgY2FjaGUuXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtTb3VyY2VNYXBHZW5lcmF0b3J9IG9iamVjdCB3aXRoIHNvdXJjZSBtYXAgaW5mb3JtYXRpb25cbiAgICAgKi9cbiAgICBjb25zdW1lcigpIHtcbiAgICAgICAgaWYgKCAhdGhpcy5jb25zdW1lckNhY2hlICkge1xuICAgICAgICAgICAgdGhpcy5jb25zdW1lckNhY2hlID0gbmV3IG1vemlsbGEuU291cmNlTWFwQ29uc3VtZXIodGhpcy50ZXh0KTtcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gdGhpcy5jb25zdW1lckNhY2hlO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIERvZXMgc291cmNlIG1hcCBjb250YWlucyBgc291cmNlc0NvbnRlbnRgIHdpdGggaW5wdXQgc291cmNlIHRleHQuXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtib29sZWFufSBJcyBgc291cmNlc0NvbnRlbnRgIHByZXNlbnRcbiAgICAgKi9cbiAgICB3aXRoQ29udGVudCgpIHtcbiAgICAgICAgcmV0dXJuICEhKHRoaXMuY29uc3VtZXIoKS5zb3VyY2VzQ29udGVudCAmJlxuICAgICAgICAgICAgICAgICAgdGhpcy5jb25zdW1lcigpLnNvdXJjZXNDb250ZW50Lmxlbmd0aCA+IDApO1xuICAgIH1cblxuICAgIHN0YXJ0V2l0aChzdHJpbmcsIHN0YXJ0KSB7XG4gICAgICAgIGlmICggIXN0cmluZyApIHJldHVybiBmYWxzZTtcbiAgICAgICAgcmV0dXJuIHN0cmluZy5zdWJzdHIoMCwgc3RhcnQubGVuZ3RoKSA9PT0gc3RhcnQ7XG4gICAgfVxuXG4gICAgbG9hZEFubm90YXRpb24oY3NzKSB7XG4gICAgICAgIGxldCBtYXRjaCA9IGNzcy5tYXRjaCgvXFwvXFwqXFxzKiMgc291cmNlTWFwcGluZ1VSTD0oLiopXFxzKlxcKlxcLy8pO1xuICAgICAgICBpZiAoIG1hdGNoICkgdGhpcy5hbm5vdGF0aW9uID0gbWF0Y2hbMV0udHJpbSgpO1xuICAgIH1cblxuICAgIGRlY29kZUlubGluZSh0ZXh0KSB7XG4gICAgICAgIGxldCB1dGZkNjQgPSAnZGF0YTphcHBsaWNhdGlvbi9qc29uO2NoYXJzZXQ9dXRmLTg7YmFzZTY0LCc7XG4gICAgICAgIGxldCB1dGY2NCAgPSAnZGF0YTphcHBsaWNhdGlvbi9qc29uO2NoYXJzZXQ9dXRmODtiYXNlNjQsJztcbiAgICAgICAgbGV0IGI2NCAgICA9ICdkYXRhOmFwcGxpY2F0aW9uL2pzb247YmFzZTY0LCc7XG4gICAgICAgIGxldCB1cmkgICAgPSAnZGF0YTphcHBsaWNhdGlvbi9qc29uLCc7XG5cbiAgICAgICAgaWYgKCB0aGlzLnN0YXJ0V2l0aCh0ZXh0LCB1cmkpICkge1xuICAgICAgICAgICAgcmV0dXJuIGRlY29kZVVSSUNvbXBvbmVudCggdGV4dC5zdWJzdHIodXJpLmxlbmd0aCkgKTtcblxuICAgICAgICB9IGVsc2UgaWYgKCB0aGlzLnN0YXJ0V2l0aCh0ZXh0LCBiNjQpICkge1xuICAgICAgICAgICAgcmV0dXJuIEJhc2U2NC5kZWNvZGUoIHRleHQuc3Vic3RyKGI2NC5sZW5ndGgpICk7XG5cbiAgICAgICAgfSBlbHNlIGlmICggdGhpcy5zdGFydFdpdGgodGV4dCwgdXRmNjQpICkge1xuICAgICAgICAgICAgcmV0dXJuIEJhc2U2NC5kZWNvZGUoIHRleHQuc3Vic3RyKHV0ZjY0Lmxlbmd0aCkgKTtcblxuICAgICAgICB9IGVsc2UgaWYgKCB0aGlzLnN0YXJ0V2l0aCh0ZXh0LCB1dGZkNjQpICkge1xuICAgICAgICAgICAgcmV0dXJuIEJhc2U2NC5kZWNvZGUoIHRleHQuc3Vic3RyKHV0ZmQ2NC5sZW5ndGgpICk7XG5cbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIGxldCBlbmNvZGluZyA9IHRleHQubWF0Y2goL2RhdGE6YXBwbGljYXRpb25cXC9qc29uOyhbXixdKyksLylbMV07XG4gICAgICAgICAgICB0aHJvdyBuZXcgRXJyb3IoJ1Vuc3VwcG9ydGVkIHNvdXJjZSBtYXAgZW5jb2RpbmcgJyArIGVuY29kaW5nKTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIGxvYWRNYXAoZmlsZSwgcHJldikge1xuICAgICAgICBpZiAoIHByZXYgPT09IGZhbHNlICkgcmV0dXJuIGZhbHNlO1xuXG4gICAgICAgIGlmICggcHJldiApIHtcbiAgICAgICAgICAgIGlmICggdHlwZW9mIHByZXYgPT09ICdzdHJpbmcnICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBwcmV2O1xuICAgICAgICAgICAgfSBlbHNlIGlmICggdHlwZW9mIHByZXYgPT09ICdmdW5jdGlvbicgKSB7XG4gICAgICAgICAgICAgICAgbGV0IHByZXZQYXRoID0gcHJldihmaWxlKTtcbiAgICAgICAgICAgICAgICBpZiAoIHByZXZQYXRoICYmIGZzLmV4aXN0c1N5bmMgJiYgZnMuZXhpc3RzU3luYyhwcmV2UGF0aCkgKSB7XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiBmcy5yZWFkRmlsZVN5bmMocHJldlBhdGgsICd1dGYtOCcpLnRvU3RyaW5nKCkudHJpbSgpO1xuICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgIHRocm93IG5ldyBFcnJvcignVW5hYmxlIHRvIGxvYWQgcHJldmlvdXMgc291cmNlIG1hcDogJyArXG4gICAgICAgICAgICAgICAgICAgIHByZXZQYXRoLnRvU3RyaW5nKCkpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH0gZWxzZSBpZiAoIHByZXYgaW5zdGFuY2VvZiBtb3ppbGxhLlNvdXJjZU1hcENvbnN1bWVyICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBtb3ppbGxhLlNvdXJjZU1hcEdlbmVyYXRvclxuICAgICAgICAgICAgICAgICAgICAuZnJvbVNvdXJjZU1hcChwcmV2KS50b1N0cmluZygpO1xuICAgICAgICAgICAgfSBlbHNlIGlmICggcHJldiBpbnN0YW5jZW9mIG1vemlsbGEuU291cmNlTWFwR2VuZXJhdG9yICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBwcmV2LnRvU3RyaW5nKCk7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKCB0aGlzLmlzTWFwKHByZXYpICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBKU09OLnN0cmluZ2lmeShwcmV2KTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgdGhyb3cgbmV3IEVycm9yKCdVbnN1cHBvcnRlZCBwcmV2aW91cyBzb3VyY2UgbWFwIGZvcm1hdDogJyArXG4gICAgICAgICAgICAgICAgICAgIHByZXYudG9TdHJpbmcoKSk7XG4gICAgICAgICAgICB9XG5cbiAgICAgICAgfSBlbHNlIGlmICggdGhpcy5pbmxpbmUgKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5kZWNvZGVJbmxpbmUodGhpcy5hbm5vdGF0aW9uKTtcblxuICAgICAgICB9IGVsc2UgaWYgKCB0aGlzLmFubm90YXRpb24gKSB7XG4gICAgICAgICAgICBsZXQgbWFwID0gdGhpcy5hbm5vdGF0aW9uO1xuICAgICAgICAgICAgaWYgKCBmaWxlICkgbWFwID0gcGF0aC5qb2luKHBhdGguZGlybmFtZShmaWxlKSwgbWFwKTtcblxuICAgICAgICAgICAgdGhpcy5yb290ID0gcGF0aC5kaXJuYW1lKG1hcCk7XG4gICAgICAgICAgICBpZiAoIGZzLmV4aXN0c1N5bmMgJiYgZnMuZXhpc3RzU3luYyhtYXApICkge1xuICAgICAgICAgICAgICAgIHJldHVybiBmcy5yZWFkRmlsZVN5bmMobWFwLCAndXRmLTgnKS50b1N0cmluZygpLnRyaW0oKTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgfVxuXG4gICAgaXNNYXAobWFwKSB7XG4gICAgICAgIGlmICggdHlwZW9mIG1hcCAhPT0gJ29iamVjdCcgKSByZXR1cm4gZmFsc2U7XG4gICAgICAgIHJldHVybiB0eXBlb2YgbWFwLm1hcHBpbmdzID09PSAnc3RyaW5nJyB8fFxuICAgICAgICAgICAgICAgdHlwZW9mIG1hcC5fbWFwcGluZ3MgPT09ICdzdHJpbmcnO1xuICAgIH1cbn1cblxuZXhwb3J0IGRlZmF1bHQgUHJldmlvdXNNYXA7XG4iXX0=
