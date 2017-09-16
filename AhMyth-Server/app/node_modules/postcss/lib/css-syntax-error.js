'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _supportsColor = require('supports-color');

var _supportsColor2 = _interopRequireDefault(_supportsColor);

var _chalk = require('chalk');

var _chalk2 = _interopRequireDefault(_chalk);

var _terminalHighlight = require('./terminal-highlight');

var _terminalHighlight2 = _interopRequireDefault(_terminalHighlight);

var _warnOnce = require('./warn-once');

var _warnOnce2 = _interopRequireDefault(_warnOnce);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

/**
 * The CSS parser throws this error for broken CSS.
 *
 * Custom parsers can throw this error for broken custom syntax using
 * the {@link Node#error} method.
 *
 * PostCSS will use the input source map to detect the original error location.
 * If you wrote a Sass file, compiled it to CSS and then parsed it with PostCSS,
 * PostCSS will show the original position in the Sass file.
 *
 * If you need the position in the PostCSS input
 * (e.g., to debug the previous compiler), use `error.input.file`.
 *
 * @example
 * // Catching and checking syntax error
 * try {
 *   postcss.parse('a{')
 * } catch (error) {
 *   if ( error.name === 'CssSyntaxError' ) {
 *     error //=> CssSyntaxError
 *   }
 * }
 *
 * @example
 * // Raising error from plugin
 * throw node.error('Unknown variable', { plugin: 'postcss-vars' });
 */
var CssSyntaxError = function () {

    /**
     * @param {string} message  - error message
     * @param {number} [line]   - source line of the error
     * @param {number} [column] - source column of the error
     * @param {string} [source] - source code of the broken file
     * @param {string} [file]   - absolute path to the broken file
     * @param {string} [plugin] - PostCSS plugin name, if error came from plugin
     */
    function CssSyntaxError(message, line, column, source, file, plugin) {
        _classCallCheck(this, CssSyntaxError);

        /**
         * @member {string} - Always equal to `'CssSyntaxError'`. You should
         *                    always check error type
         *                    by `error.name === 'CssSyntaxError'` instead of
         *                    `error instanceof CssSyntaxError`, because
         *                    npm could have several PostCSS versions.
         *
         * @example
         * if ( error.name === 'CssSyntaxError' ) {
         *   error //=> CssSyntaxError
         * }
         */
        this.name = 'CssSyntaxError';
        /**
         * @member {string} - Error message.
         *
         * @example
         * error.message //=> 'Unclosed block'
         */
        this.reason = message;

        if (file) {
            /**
             * @member {string} - Absolute path to the broken file.
             *
             * @example
             * error.file       //=> 'a.sass'
             * error.input.file //=> 'a.css'
             */
            this.file = file;
        }
        if (source) {
            /**
             * @member {string} - Source code of the broken file.
             *
             * @example
             * error.source       //=> 'a { b {} }'
             * error.input.column //=> 'a b { }'
             */
            this.source = source;
        }
        if (plugin) {
            /**
             * @member {string} - Plugin name, if error came from plugin.
             *
             * @example
             * error.plugin //=> 'postcss-vars'
             */
            this.plugin = plugin;
        }
        if (typeof line !== 'undefined' && typeof column !== 'undefined') {
            /**
             * @member {number} - Source line of the error.
             *
             * @example
             * error.line       //=> 2
             * error.input.line //=> 4
             */
            this.line = line;
            /**
             * @member {number} - Source column of the error.
             *
             * @example
             * error.column       //=> 1
             * error.input.column //=> 4
             */
            this.column = column;
        }

        this.setMessage();

        if (Error.captureStackTrace) {
            Error.captureStackTrace(this, CssSyntaxError);
        }
    }

    CssSyntaxError.prototype.setMessage = function setMessage() {
        /**
         * @member {string} - Full error text in the GNU error format
         *                    with plugin, file, line and column.
         *
         * @example
         * error.message //=> 'a.css:1:1: Unclosed block'
         */
        this.message = this.plugin ? this.plugin + ': ' : '';
        this.message += this.file ? this.file : '<css input>';
        if (typeof this.line !== 'undefined') {
            this.message += ':' + this.line + ':' + this.column;
        }
        this.message += ': ' + this.reason;
    };

    /**
     * Returns a few lines of CSS source that caused the error.
     *
     * If the CSS has an input source map without `sourceContent`,
     * this method will return an empty string.
     *
     * @param {boolean} [color] whether arrow will be colored red by terminal
     *                          color codes. By default, PostCSS will detect
     *                          color support by `process.stdout.isTTY`
     *                          and `process.env.NODE_DISABLE_COLORS`.
     *
     * @example
     * error.showSourceCode() //=> "  4 | }
     *                        //      5 | a {
     *                        //    > 6 |   bad
     *                        //        |   ^
     *                        //      7 | }
     *                        //      8 | b {"
     *
     * @return {string} few lines of CSS source that caused the error
     */


    CssSyntaxError.prototype.showSourceCode = function showSourceCode(color) {
        var _this = this;

        if (!this.source) return '';

        var css = this.source;
        if (typeof color === 'undefined') color = _supportsColor2.default;
        if (color) css = (0, _terminalHighlight2.default)(css);

        var lines = css.split(/\r?\n/);
        var start = Math.max(this.line - 3, 0);
        var end = Math.min(this.line + 2, lines.length);

        var maxWidth = String(end).length;
        var colors = new _chalk2.default.constructor({ enabled: true });

        function mark(text) {
            if (color) {
                return colors.red.bold(text);
            } else {
                return text;
            }
        }
        function aside(text) {
            if (color) {
                return colors.gray(text);
            } else {
                return text;
            }
        }

        return lines.slice(start, end).map(function (line, index) {
            var number = start + 1 + index;
            var gutter = ' ' + (' ' + number).slice(-maxWidth) + ' | ';
            if (number === _this.line) {
                var spacing = aside(gutter.replace(/\d/g, ' ')) + line.slice(0, _this.column - 1).replace(/[^\t]/g, ' ');
                return mark('>') + aside(gutter) + line + '\n ' + spacing + mark('^');
            } else {
                return ' ' + aside(gutter) + line;
            }
        }).join('\n');
    };

    /**
     * Returns error position, message and source code of the broken part.
     *
     * @example
     * error.toString() //=> "CssSyntaxError: app.css:1:1: Unclosed block
     *                  //    > 1 | a {
     *                  //        | ^"
     *
     * @return {string} error position, message and source code
     */


    CssSyntaxError.prototype.toString = function toString() {
        var code = this.showSourceCode();
        if (code) {
            code = '\n\n' + code + '\n';
        }
        return this.name + ': ' + this.message + code;
    };

    _createClass(CssSyntaxError, [{
        key: 'generated',
        get: function get() {
            (0, _warnOnce2.default)('CssSyntaxError#generated is depreacted. Use input instead.');
            return this.input;
        }

        /**
         * @memberof CssSyntaxError#
         * @member {Input} input - Input object with PostCSS internal information
         *                         about input file. If input has source map
         *                         from previous tool, PostCSS will use origin
         *                         (for example, Sass) source. You can use this
         *                         object to get PostCSS input source.
         *
         * @example
         * error.input.file //=> 'a.css'
         * error.file       //=> 'a.sass'
         */

    }]);

    return CssSyntaxError;
}();

exports.default = CssSyntaxError;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvY3NzLXN5bnRheC1lcnJvci5lczYiXSwibmFtZXMiOlsiQ3NzU3ludGF4RXJyb3IiLCJtZXNzYWdlIiwibGluZSIsImNvbHVtbiIsInNvdXJjZSIsImZpbGUiLCJwbHVnaW4iLCJuYW1lIiwicmVhc29uIiwic2V0TWVzc2FnZSIsIkVycm9yIiwiY2FwdHVyZVN0YWNrVHJhY2UiLCJzaG93U291cmNlQ29kZSIsImNvbG9yIiwiY3NzIiwibGluZXMiLCJzcGxpdCIsInN0YXJ0IiwiTWF0aCIsIm1heCIsImVuZCIsIm1pbiIsImxlbmd0aCIsIm1heFdpZHRoIiwiU3RyaW5nIiwiY29sb3JzIiwiY29uc3RydWN0b3IiLCJlbmFibGVkIiwibWFyayIsInRleHQiLCJyZWQiLCJib2xkIiwiYXNpZGUiLCJncmF5Iiwic2xpY2UiLCJtYXAiLCJpbmRleCIsIm51bWJlciIsImd1dHRlciIsInNwYWNpbmciLCJyZXBsYWNlIiwiam9pbiIsInRvU3RyaW5nIiwiY29kZSIsImlucHV0Il0sIm1hcHBpbmdzIjoiOzs7Ozs7QUFBQTs7OztBQUNBOzs7O0FBRUE7Ozs7QUFDQTs7Ozs7Ozs7QUFFQTs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7O0lBMkJNQSxjOztBQUVGOzs7Ozs7OztBQVFBLDRCQUFZQyxPQUFaLEVBQXFCQyxJQUFyQixFQUEyQkMsTUFBM0IsRUFBbUNDLE1BQW5DLEVBQTJDQyxJQUEzQyxFQUFpREMsTUFBakQsRUFBeUQ7QUFBQTs7QUFDckQ7Ozs7Ozs7Ozs7OztBQVlBLGFBQUtDLElBQUwsR0FBYyxnQkFBZDtBQUNBOzs7Ozs7QUFNQSxhQUFLQyxNQUFMLEdBQWNQLE9BQWQ7O0FBRUEsWUFBS0ksSUFBTCxFQUFZO0FBQ1I7Ozs7Ozs7QUFPQSxpQkFBS0EsSUFBTCxHQUFZQSxJQUFaO0FBQ0g7QUFDRCxZQUFLRCxNQUFMLEVBQWM7QUFDVjs7Ozs7OztBQU9BLGlCQUFLQSxNQUFMLEdBQWNBLE1BQWQ7QUFDSDtBQUNELFlBQUtFLE1BQUwsRUFBYztBQUNWOzs7Ozs7QUFNQSxpQkFBS0EsTUFBTCxHQUFjQSxNQUFkO0FBQ0g7QUFDRCxZQUFLLE9BQU9KLElBQVAsS0FBZ0IsV0FBaEIsSUFBK0IsT0FBT0MsTUFBUCxLQUFrQixXQUF0RCxFQUFvRTtBQUNoRTs7Ozs7OztBQU9BLGlCQUFLRCxJQUFMLEdBQWNBLElBQWQ7QUFDQTs7Ozs7OztBQU9BLGlCQUFLQyxNQUFMLEdBQWNBLE1BQWQ7QUFDSDs7QUFFRCxhQUFLTSxVQUFMOztBQUVBLFlBQUtDLE1BQU1DLGlCQUFYLEVBQStCO0FBQzNCRCxrQkFBTUMsaUJBQU4sQ0FBd0IsSUFBeEIsRUFBOEJYLGNBQTlCO0FBQ0g7QUFDSjs7NkJBRURTLFUseUJBQWE7QUFDVDs7Ozs7OztBQU9BLGFBQUtSLE9BQUwsR0FBZ0IsS0FBS0ssTUFBTCxHQUFjLEtBQUtBLE1BQUwsR0FBYyxJQUE1QixHQUFtQyxFQUFuRDtBQUNBLGFBQUtMLE9BQUwsSUFBZ0IsS0FBS0ksSUFBTCxHQUFZLEtBQUtBLElBQWpCLEdBQXdCLGFBQXhDO0FBQ0EsWUFBSyxPQUFPLEtBQUtILElBQVosS0FBcUIsV0FBMUIsRUFBd0M7QUFDcEMsaUJBQUtELE9BQUwsSUFBZ0IsTUFBTSxLQUFLQyxJQUFYLEdBQWtCLEdBQWxCLEdBQXdCLEtBQUtDLE1BQTdDO0FBQ0g7QUFDRCxhQUFLRixPQUFMLElBQWdCLE9BQU8sS0FBS08sTUFBNUI7QUFDSCxLOztBQUVEOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs2QkFxQkFJLGMsMkJBQWVDLEssRUFBTztBQUFBOztBQUNsQixZQUFLLENBQUMsS0FBS1QsTUFBWCxFQUFvQixPQUFPLEVBQVA7O0FBRXBCLFlBQUlVLE1BQU0sS0FBS1YsTUFBZjtBQUNBLFlBQUssT0FBT1MsS0FBUCxLQUFpQixXQUF0QixFQUFvQ0E7QUFDcEMsWUFBS0EsS0FBTCxFQUFhQyxNQUFNLGlDQUFrQkEsR0FBbEIsQ0FBTjs7QUFFYixZQUFJQyxRQUFRRCxJQUFJRSxLQUFKLENBQVUsT0FBVixDQUFaO0FBQ0EsWUFBSUMsUUFBUUMsS0FBS0MsR0FBTCxDQUFTLEtBQUtqQixJQUFMLEdBQVksQ0FBckIsRUFBd0IsQ0FBeEIsQ0FBWjtBQUNBLFlBQUlrQixNQUFRRixLQUFLRyxHQUFMLENBQVMsS0FBS25CLElBQUwsR0FBWSxDQUFyQixFQUF3QmEsTUFBTU8sTUFBOUIsQ0FBWjs7QUFFQSxZQUFJQyxXQUFXQyxPQUFPSixHQUFQLEVBQVlFLE1BQTNCO0FBQ0EsWUFBSUcsU0FBUyxJQUFJLGdCQUFNQyxXQUFWLENBQXNCLEVBQUVDLFNBQVMsSUFBWCxFQUF0QixDQUFiOztBQUVBLGlCQUFTQyxJQUFULENBQWNDLElBQWQsRUFBb0I7QUFDaEIsZ0JBQUtoQixLQUFMLEVBQWE7QUFDVCx1QkFBT1ksT0FBT0ssR0FBUCxDQUFXQyxJQUFYLENBQWdCRixJQUFoQixDQUFQO0FBQ0gsYUFGRCxNQUVPO0FBQ0gsdUJBQU9BLElBQVA7QUFDSDtBQUNKO0FBQ0QsaUJBQVNHLEtBQVQsQ0FBZUgsSUFBZixFQUFxQjtBQUNqQixnQkFBS2hCLEtBQUwsRUFBYTtBQUNULHVCQUFPWSxPQUFPUSxJQUFQLENBQVlKLElBQVosQ0FBUDtBQUNILGFBRkQsTUFFTztBQUNILHVCQUFPQSxJQUFQO0FBQ0g7QUFDSjs7QUFFRCxlQUFPZCxNQUFNbUIsS0FBTixDQUFZakIsS0FBWixFQUFtQkcsR0FBbkIsRUFBd0JlLEdBQXhCLENBQTZCLFVBQUNqQyxJQUFELEVBQU9rQyxLQUFQLEVBQWlCO0FBQ2pELGdCQUFJQyxTQUFTcEIsUUFBUSxDQUFSLEdBQVltQixLQUF6QjtBQUNBLGdCQUFJRSxTQUFTLE1BQU0sQ0FBQyxNQUFNRCxNQUFQLEVBQWVILEtBQWYsQ0FBcUIsQ0FBQ1gsUUFBdEIsQ0FBTixHQUF3QyxLQUFyRDtBQUNBLGdCQUFLYyxXQUFXLE1BQUtuQyxJQUFyQixFQUE0QjtBQUN4QixvQkFBSXFDLFVBQ0FQLE1BQU1NLE9BQU9FLE9BQVAsQ0FBZSxLQUFmLEVBQXNCLEdBQXRCLENBQU4sSUFDQXRDLEtBQUtnQyxLQUFMLENBQVcsQ0FBWCxFQUFjLE1BQUsvQixNQUFMLEdBQWMsQ0FBNUIsRUFBK0JxQyxPQUEvQixDQUF1QyxRQUF2QyxFQUFpRCxHQUFqRCxDQUZKO0FBR0EsdUJBQU9aLEtBQUssR0FBTCxJQUFZSSxNQUFNTSxNQUFOLENBQVosR0FBNEJwQyxJQUE1QixHQUFtQyxLQUFuQyxHQUNBcUMsT0FEQSxHQUNVWCxLQUFLLEdBQUwsQ0FEakI7QUFFSCxhQU5ELE1BTU87QUFDSCx1QkFBTyxNQUFNSSxNQUFNTSxNQUFOLENBQU4sR0FBc0JwQyxJQUE3QjtBQUNIO0FBQ0osU0FaTSxFQVlKdUMsSUFaSSxDQVlDLElBWkQsQ0FBUDtBQWFILEs7O0FBRUQ7Ozs7Ozs7Ozs7Ozs2QkFVQUMsUSx1QkFBVztBQUNQLFlBQUlDLE9BQU8sS0FBSy9CLGNBQUwsRUFBWDtBQUNBLFlBQUsrQixJQUFMLEVBQVk7QUFDUkEsbUJBQU8sU0FBU0EsSUFBVCxHQUFnQixJQUF2QjtBQUNIO0FBQ0QsZUFBTyxLQUFLcEMsSUFBTCxHQUFZLElBQVosR0FBbUIsS0FBS04sT0FBeEIsR0FBa0MwQyxJQUF6QztBQUNILEs7Ozs7NEJBRWU7QUFDWixvQ0FBUyw0REFBVDtBQUNBLG1CQUFPLEtBQUtDLEtBQVo7QUFDSDs7QUFFRDs7Ozs7Ozs7Ozs7Ozs7Ozs7O2tCQWVXNUMsYyIsImZpbGUiOiJjc3Mtc3ludGF4LWVycm9yLmpzIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IHN1cHBvcnRzQ29sb3IgZnJvbSAnc3VwcG9ydHMtY29sb3InO1xuaW1wb3J0IGNoYWxrICAgICAgICAgZnJvbSAnY2hhbGsnO1xuXG5pbXBvcnQgdGVybWluYWxIaWdobGlnaHQgZnJvbSAnLi90ZXJtaW5hbC1oaWdobGlnaHQnO1xuaW1wb3J0IHdhcm5PbmNlICAgICAgICAgIGZyb20gJy4vd2Fybi1vbmNlJztcblxuLyoqXG4gKiBUaGUgQ1NTIHBhcnNlciB0aHJvd3MgdGhpcyBlcnJvciBmb3IgYnJva2VuIENTUy5cbiAqXG4gKiBDdXN0b20gcGFyc2VycyBjYW4gdGhyb3cgdGhpcyBlcnJvciBmb3IgYnJva2VuIGN1c3RvbSBzeW50YXggdXNpbmdcbiAqIHRoZSB7QGxpbmsgTm9kZSNlcnJvcn0gbWV0aG9kLlxuICpcbiAqIFBvc3RDU1Mgd2lsbCB1c2UgdGhlIGlucHV0IHNvdXJjZSBtYXAgdG8gZGV0ZWN0IHRoZSBvcmlnaW5hbCBlcnJvciBsb2NhdGlvbi5cbiAqIElmIHlvdSB3cm90ZSBhIFNhc3MgZmlsZSwgY29tcGlsZWQgaXQgdG8gQ1NTIGFuZCB0aGVuIHBhcnNlZCBpdCB3aXRoIFBvc3RDU1MsXG4gKiBQb3N0Q1NTIHdpbGwgc2hvdyB0aGUgb3JpZ2luYWwgcG9zaXRpb24gaW4gdGhlIFNhc3MgZmlsZS5cbiAqXG4gKiBJZiB5b3UgbmVlZCB0aGUgcG9zaXRpb24gaW4gdGhlIFBvc3RDU1MgaW5wdXRcbiAqIChlLmcuLCB0byBkZWJ1ZyB0aGUgcHJldmlvdXMgY29tcGlsZXIpLCB1c2UgYGVycm9yLmlucHV0LmZpbGVgLlxuICpcbiAqIEBleGFtcGxlXG4gKiAvLyBDYXRjaGluZyBhbmQgY2hlY2tpbmcgc3ludGF4IGVycm9yXG4gKiB0cnkge1xuICogICBwb3N0Y3NzLnBhcnNlKCdheycpXG4gKiB9IGNhdGNoIChlcnJvcikge1xuICogICBpZiAoIGVycm9yLm5hbWUgPT09ICdDc3NTeW50YXhFcnJvcicgKSB7XG4gKiAgICAgZXJyb3IgLy89PiBDc3NTeW50YXhFcnJvclxuICogICB9XG4gKiB9XG4gKlxuICogQGV4YW1wbGVcbiAqIC8vIFJhaXNpbmcgZXJyb3IgZnJvbSBwbHVnaW5cbiAqIHRocm93IG5vZGUuZXJyb3IoJ1Vua25vd24gdmFyaWFibGUnLCB7IHBsdWdpbjogJ3Bvc3Rjc3MtdmFycycgfSk7XG4gKi9cbmNsYXNzIENzc1N5bnRheEVycm9yIHtcblxuICAgIC8qKlxuICAgICAqIEBwYXJhbSB7c3RyaW5nfSBtZXNzYWdlICAtIGVycm9yIG1lc3NhZ2VcbiAgICAgKiBAcGFyYW0ge251bWJlcn0gW2xpbmVdICAgLSBzb3VyY2UgbGluZSBvZiB0aGUgZXJyb3JcbiAgICAgKiBAcGFyYW0ge251bWJlcn0gW2NvbHVtbl0gLSBzb3VyY2UgY29sdW1uIG9mIHRoZSBlcnJvclxuICAgICAqIEBwYXJhbSB7c3RyaW5nfSBbc291cmNlXSAtIHNvdXJjZSBjb2RlIG9mIHRoZSBicm9rZW4gZmlsZVxuICAgICAqIEBwYXJhbSB7c3RyaW5nfSBbZmlsZV0gICAtIGFic29sdXRlIHBhdGggdG8gdGhlIGJyb2tlbiBmaWxlXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IFtwbHVnaW5dIC0gUG9zdENTUyBwbHVnaW4gbmFtZSwgaWYgZXJyb3IgY2FtZSBmcm9tIHBsdWdpblxuICAgICAqL1xuICAgIGNvbnN0cnVjdG9yKG1lc3NhZ2UsIGxpbmUsIGNvbHVtbiwgc291cmNlLCBmaWxlLCBwbHVnaW4pIHtcbiAgICAgICAgLyoqXG4gICAgICAgICAqIEBtZW1iZXIge3N0cmluZ30gLSBBbHdheXMgZXF1YWwgdG8gYCdDc3NTeW50YXhFcnJvcidgLiBZb3Ugc2hvdWxkXG4gICAgICAgICAqICAgICAgICAgICAgICAgICAgICBhbHdheXMgY2hlY2sgZXJyb3IgdHlwZVxuICAgICAgICAgKiAgICAgICAgICAgICAgICAgICAgYnkgYGVycm9yLm5hbWUgPT09ICdDc3NTeW50YXhFcnJvcidgIGluc3RlYWQgb2ZcbiAgICAgICAgICogICAgICAgICAgICAgICAgICAgIGBlcnJvciBpbnN0YW5jZW9mIENzc1N5bnRheEVycm9yYCwgYmVjYXVzZVxuICAgICAgICAgKiAgICAgICAgICAgICAgICAgICAgbnBtIGNvdWxkIGhhdmUgc2V2ZXJhbCBQb3N0Q1NTIHZlcnNpb25zLlxuICAgICAgICAgKlxuICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgKiBpZiAoIGVycm9yLm5hbWUgPT09ICdDc3NTeW50YXhFcnJvcicgKSB7XG4gICAgICAgICAqICAgZXJyb3IgLy89PiBDc3NTeW50YXhFcnJvclxuICAgICAgICAgKiB9XG4gICAgICAgICAqL1xuICAgICAgICB0aGlzLm5hbWUgICA9ICdDc3NTeW50YXhFcnJvcic7XG4gICAgICAgIC8qKlxuICAgICAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IC0gRXJyb3IgbWVzc2FnZS5cbiAgICAgICAgICpcbiAgICAgICAgICogQGV4YW1wbGVcbiAgICAgICAgICogZXJyb3IubWVzc2FnZSAvLz0+ICdVbmNsb3NlZCBibG9jaydcbiAgICAgICAgICovXG4gICAgICAgIHRoaXMucmVhc29uID0gbWVzc2FnZTtcblxuICAgICAgICBpZiAoIGZpbGUgKSB7XG4gICAgICAgICAgICAvKipcbiAgICAgICAgICAgICAqIEBtZW1iZXIge3N0cmluZ30gLSBBYnNvbHV0ZSBwYXRoIHRvIHRoZSBicm9rZW4gZmlsZS5cbiAgICAgICAgICAgICAqXG4gICAgICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgICAgICogZXJyb3IuZmlsZSAgICAgICAvLz0+ICdhLnNhc3MnXG4gICAgICAgICAgICAgKiBlcnJvci5pbnB1dC5maWxlIC8vPT4gJ2EuY3NzJ1xuICAgICAgICAgICAgICovXG4gICAgICAgICAgICB0aGlzLmZpbGUgPSBmaWxlO1xuICAgICAgICB9XG4gICAgICAgIGlmICggc291cmNlICkge1xuICAgICAgICAgICAgLyoqXG4gICAgICAgICAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IC0gU291cmNlIGNvZGUgb2YgdGhlIGJyb2tlbiBmaWxlLlxuICAgICAgICAgICAgICpcbiAgICAgICAgICAgICAqIEBleGFtcGxlXG4gICAgICAgICAgICAgKiBlcnJvci5zb3VyY2UgICAgICAgLy89PiAnYSB7IGIge30gfSdcbiAgICAgICAgICAgICAqIGVycm9yLmlucHV0LmNvbHVtbiAvLz0+ICdhIGIgeyB9J1xuICAgICAgICAgICAgICovXG4gICAgICAgICAgICB0aGlzLnNvdXJjZSA9IHNvdXJjZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoIHBsdWdpbiApIHtcbiAgICAgICAgICAgIC8qKlxuICAgICAgICAgICAgICogQG1lbWJlciB7c3RyaW5nfSAtIFBsdWdpbiBuYW1lLCBpZiBlcnJvciBjYW1lIGZyb20gcGx1Z2luLlxuICAgICAgICAgICAgICpcbiAgICAgICAgICAgICAqIEBleGFtcGxlXG4gICAgICAgICAgICAgKiBlcnJvci5wbHVnaW4gLy89PiAncG9zdGNzcy12YXJzJ1xuICAgICAgICAgICAgICovXG4gICAgICAgICAgICB0aGlzLnBsdWdpbiA9IHBsdWdpbjtcbiAgICAgICAgfVxuICAgICAgICBpZiAoIHR5cGVvZiBsaW5lICE9PSAndW5kZWZpbmVkJyAmJiB0eXBlb2YgY29sdW1uICE9PSAndW5kZWZpbmVkJyApIHtcbiAgICAgICAgICAgIC8qKlxuICAgICAgICAgICAgICogQG1lbWJlciB7bnVtYmVyfSAtIFNvdXJjZSBsaW5lIG9mIHRoZSBlcnJvci5cbiAgICAgICAgICAgICAqXG4gICAgICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgICAgICogZXJyb3IubGluZSAgICAgICAvLz0+IDJcbiAgICAgICAgICAgICAqIGVycm9yLmlucHV0LmxpbmUgLy89PiA0XG4gICAgICAgICAgICAgKi9cbiAgICAgICAgICAgIHRoaXMubGluZSAgID0gbGluZTtcbiAgICAgICAgICAgIC8qKlxuICAgICAgICAgICAgICogQG1lbWJlciB7bnVtYmVyfSAtIFNvdXJjZSBjb2x1bW4gb2YgdGhlIGVycm9yLlxuICAgICAgICAgICAgICpcbiAgICAgICAgICAgICAqIEBleGFtcGxlXG4gICAgICAgICAgICAgKiBlcnJvci5jb2x1bW4gICAgICAgLy89PiAxXG4gICAgICAgICAgICAgKiBlcnJvci5pbnB1dC5jb2x1bW4gLy89PiA0XG4gICAgICAgICAgICAgKi9cbiAgICAgICAgICAgIHRoaXMuY29sdW1uID0gY29sdW1uO1xuICAgICAgICB9XG5cbiAgICAgICAgdGhpcy5zZXRNZXNzYWdlKCk7XG5cbiAgICAgICAgaWYgKCBFcnJvci5jYXB0dXJlU3RhY2tUcmFjZSApIHtcbiAgICAgICAgICAgIEVycm9yLmNhcHR1cmVTdGFja1RyYWNlKHRoaXMsIENzc1N5bnRheEVycm9yKTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIHNldE1lc3NhZ2UoKSB7XG4gICAgICAgIC8qKlxuICAgICAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IC0gRnVsbCBlcnJvciB0ZXh0IGluIHRoZSBHTlUgZXJyb3IgZm9ybWF0XG4gICAgICAgICAqICAgICAgICAgICAgICAgICAgICB3aXRoIHBsdWdpbiwgZmlsZSwgbGluZSBhbmQgY29sdW1uLlxuICAgICAgICAgKlxuICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgKiBlcnJvci5tZXNzYWdlIC8vPT4gJ2EuY3NzOjE6MTogVW5jbG9zZWQgYmxvY2snXG4gICAgICAgICAqL1xuICAgICAgICB0aGlzLm1lc3NhZ2UgID0gdGhpcy5wbHVnaW4gPyB0aGlzLnBsdWdpbiArICc6ICcgOiAnJztcbiAgICAgICAgdGhpcy5tZXNzYWdlICs9IHRoaXMuZmlsZSA/IHRoaXMuZmlsZSA6ICc8Y3NzIGlucHV0Pic7XG4gICAgICAgIGlmICggdHlwZW9mIHRoaXMubGluZSAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICB0aGlzLm1lc3NhZ2UgKz0gJzonICsgdGhpcy5saW5lICsgJzonICsgdGhpcy5jb2x1bW47XG4gICAgICAgIH1cbiAgICAgICAgdGhpcy5tZXNzYWdlICs9ICc6ICcgKyB0aGlzLnJlYXNvbjtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIGEgZmV3IGxpbmVzIG9mIENTUyBzb3VyY2UgdGhhdCBjYXVzZWQgdGhlIGVycm9yLlxuICAgICAqXG4gICAgICogSWYgdGhlIENTUyBoYXMgYW4gaW5wdXQgc291cmNlIG1hcCB3aXRob3V0IGBzb3VyY2VDb250ZW50YCxcbiAgICAgKiB0aGlzIG1ldGhvZCB3aWxsIHJldHVybiBhbiBlbXB0eSBzdHJpbmcuXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge2Jvb2xlYW59IFtjb2xvcl0gd2hldGhlciBhcnJvdyB3aWxsIGJlIGNvbG9yZWQgcmVkIGJ5IHRlcm1pbmFsXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgIGNvbG9yIGNvZGVzLiBCeSBkZWZhdWx0LCBQb3N0Q1NTIHdpbGwgZGV0ZWN0XG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgIGNvbG9yIHN1cHBvcnQgYnkgYHByb2Nlc3Muc3Rkb3V0LmlzVFRZYFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICBhbmQgYHByb2Nlc3MuZW52Lk5PREVfRElTQUJMRV9DT0xPUlNgLlxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBlcnJvci5zaG93U291cmNlQ29kZSgpIC8vPT4gXCIgIDQgfCB9XG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAvLyAgICAgIDUgfCBhIHtcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgIC8vICAgID4gNiB8ICAgYmFkXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAvLyAgICAgICAgfCAgIF5cbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgIC8vICAgICAgNyB8IH1cbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgIC8vICAgICAgOCB8IGIge1wiXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtzdHJpbmd9IGZldyBsaW5lcyBvZiBDU1Mgc291cmNlIHRoYXQgY2F1c2VkIHRoZSBlcnJvclxuICAgICAqL1xuICAgIHNob3dTb3VyY2VDb2RlKGNvbG9yKSB7XG4gICAgICAgIGlmICggIXRoaXMuc291cmNlICkgcmV0dXJuICcnO1xuXG4gICAgICAgIGxldCBjc3MgPSB0aGlzLnNvdXJjZTtcbiAgICAgICAgaWYgKCB0eXBlb2YgY29sb3IgPT09ICd1bmRlZmluZWQnICkgY29sb3IgPSBzdXBwb3J0c0NvbG9yO1xuICAgICAgICBpZiAoIGNvbG9yICkgY3NzID0gdGVybWluYWxIaWdobGlnaHQoY3NzKTtcblxuICAgICAgICBsZXQgbGluZXMgPSBjc3Muc3BsaXQoL1xccj9cXG4vKTtcbiAgICAgICAgbGV0IHN0YXJ0ID0gTWF0aC5tYXgodGhpcy5saW5lIC0gMywgMCk7XG4gICAgICAgIGxldCBlbmQgICA9IE1hdGgubWluKHRoaXMubGluZSArIDIsIGxpbmVzLmxlbmd0aCk7XG5cbiAgICAgICAgbGV0IG1heFdpZHRoID0gU3RyaW5nKGVuZCkubGVuZ3RoO1xuICAgICAgICBsZXQgY29sb3JzID0gbmV3IGNoYWxrLmNvbnN0cnVjdG9yKHsgZW5hYmxlZDogdHJ1ZSB9KTtcblxuICAgICAgICBmdW5jdGlvbiBtYXJrKHRleHQpIHtcbiAgICAgICAgICAgIGlmICggY29sb3IgKSB7XG4gICAgICAgICAgICAgICAgcmV0dXJuIGNvbG9ycy5yZWQuYm9sZCh0ZXh0KTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgcmV0dXJuIHRleHQ7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cbiAgICAgICAgZnVuY3Rpb24gYXNpZGUodGV4dCkge1xuICAgICAgICAgICAgaWYgKCBjb2xvciApIHtcbiAgICAgICAgICAgICAgICByZXR1cm4gY29sb3JzLmdyYXkodGV4dCk7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHJldHVybiB0ZXh0O1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIGxpbmVzLnNsaWNlKHN0YXJ0LCBlbmQpLm1hcCggKGxpbmUsIGluZGV4KSA9PiB7XG4gICAgICAgICAgICBsZXQgbnVtYmVyID0gc3RhcnQgKyAxICsgaW5kZXg7XG4gICAgICAgICAgICBsZXQgZ3V0dGVyID0gJyAnICsgKCcgJyArIG51bWJlcikuc2xpY2UoLW1heFdpZHRoKSArICcgfCAnO1xuICAgICAgICAgICAgaWYgKCBudW1iZXIgPT09IHRoaXMubGluZSApIHtcbiAgICAgICAgICAgICAgICBsZXQgc3BhY2luZyA9XG4gICAgICAgICAgICAgICAgICAgIGFzaWRlKGd1dHRlci5yZXBsYWNlKC9cXGQvZywgJyAnKSkgK1xuICAgICAgICAgICAgICAgICAgICBsaW5lLnNsaWNlKDAsIHRoaXMuY29sdW1uIC0gMSkucmVwbGFjZSgvW15cXHRdL2csICcgJyk7XG4gICAgICAgICAgICAgICAgcmV0dXJuIG1hcmsoJz4nKSArIGFzaWRlKGd1dHRlcikgKyBsaW5lICsgJ1xcbiAnICtcbiAgICAgICAgICAgICAgICAgICAgICAgc3BhY2luZyArIG1hcmsoJ14nKTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgcmV0dXJuICcgJyArIGFzaWRlKGd1dHRlcikgKyBsaW5lO1xuICAgICAgICAgICAgfVxuICAgICAgICB9KS5qb2luKCdcXG4nKTtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIGVycm9yIHBvc2l0aW9uLCBtZXNzYWdlIGFuZCBzb3VyY2UgY29kZSBvZiB0aGUgYnJva2VuIHBhcnQuXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGVycm9yLnRvU3RyaW5nKCkgLy89PiBcIkNzc1N5bnRheEVycm9yOiBhcHAuY3NzOjE6MTogVW5jbG9zZWQgYmxvY2tcbiAgICAgKiAgICAgICAgICAgICAgICAgIC8vICAgID4gMSB8IGEge1xuICAgICAqICAgICAgICAgICAgICAgICAgLy8gICAgICAgIHwgXlwiXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtzdHJpbmd9IGVycm9yIHBvc2l0aW9uLCBtZXNzYWdlIGFuZCBzb3VyY2UgY29kZVxuICAgICAqL1xuICAgIHRvU3RyaW5nKCkge1xuICAgICAgICBsZXQgY29kZSA9IHRoaXMuc2hvd1NvdXJjZUNvZGUoKTtcbiAgICAgICAgaWYgKCBjb2RlICkge1xuICAgICAgICAgICAgY29kZSA9ICdcXG5cXG4nICsgY29kZSArICdcXG4nO1xuICAgICAgICB9XG4gICAgICAgIHJldHVybiB0aGlzLm5hbWUgKyAnOiAnICsgdGhpcy5tZXNzYWdlICsgY29kZTtcbiAgICB9XG5cbiAgICBnZXQgZ2VuZXJhdGVkKCkge1xuICAgICAgICB3YXJuT25jZSgnQ3NzU3ludGF4RXJyb3IjZ2VuZXJhdGVkIGlzIGRlcHJlYWN0ZWQuIFVzZSBpbnB1dCBpbnN0ZWFkLicpO1xuICAgICAgICByZXR1cm4gdGhpcy5pbnB1dDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBAbWVtYmVyb2YgQ3NzU3ludGF4RXJyb3IjXG4gICAgICogQG1lbWJlciB7SW5wdXR9IGlucHV0IC0gSW5wdXQgb2JqZWN0IHdpdGggUG9zdENTUyBpbnRlcm5hbCBpbmZvcm1hdGlvblxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgIGFib3V0IGlucHV0IGZpbGUuIElmIGlucHV0IGhhcyBzb3VyY2UgbWFwXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSBwcmV2aW91cyB0b29sLCBQb3N0Q1NTIHdpbGwgdXNlIG9yaWdpblxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgIChmb3IgZXhhbXBsZSwgU2Fzcykgc291cmNlLiBZb3UgY2FuIHVzZSB0aGlzXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgb2JqZWN0IHRvIGdldCBQb3N0Q1NTIGlucHV0IHNvdXJjZS5cbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogZXJyb3IuaW5wdXQuZmlsZSAvLz0+ICdhLmNzcydcbiAgICAgKiBlcnJvci5maWxlICAgICAgIC8vPT4gJ2Euc2FzcydcbiAgICAgKi9cblxufVxuXG5leHBvcnQgZGVmYXVsdCBDc3NTeW50YXhFcnJvcjtcbiJdfQ==
