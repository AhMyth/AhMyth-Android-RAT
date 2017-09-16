'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _cssSyntaxError = require('./css-syntax-error');

var _cssSyntaxError2 = _interopRequireDefault(_cssSyntaxError);

var _previousMap = require('./previous-map');

var _previousMap2 = _interopRequireDefault(_previousMap);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var sequence = 0;

/**
 * Represents the source CSS.
 *
 * @example
 * const root  = postcss.parse(css, { from: file });
 * const input = root.source.input;
 */

var Input = function () {

    /**
     * @param {string} css    - input CSS source
     * @param {object} [opts] - {@link Processor#process} options
     */
    function Input(css) {
        var opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        _classCallCheck(this, Input);

        /**
         * @member {string} - input CSS source
         *
         * @example
         * const input = postcss.parse('a{}', { from: file }).input;
         * input.css //=> "a{}";
         */
        this.css = css.toString();

        if (this.css[0] === '\uFEFF' || this.css[0] === '\uFFFE') {
            this.css = this.css.slice(1);
        }

        if (opts.from) {
            if (/^\w+:\/\//.test(opts.from)) {
                /**
                 * @member {string} - The absolute path to the CSS source file
                 *                    defined with the `from` option.
                 *
                 * @example
                 * const root = postcss.parse(css, { from: 'a.css' });
                 * root.source.input.file //=> '/home/ai/a.css'
                 */
                this.file = opts.from;
            } else {
                this.file = _path2.default.resolve(opts.from);
            }
        }

        var map = new _previousMap2.default(this.css, opts);
        if (map.text) {
            /**
             * @member {PreviousMap} - The input source map passed from
             *                         a compilation step before PostCSS
             *                         (for example, from Sass compiler).
             *
             * @example
             * root.source.input.map.consumer().sources //=> ['a.sass']
             */
            this.map = map;
            var file = map.consumer().file;
            if (!this.file && file) this.file = this.mapResolve(file);
        }

        if (!this.file) {
            sequence += 1;
            /**
             * @member {string} - The unique ID of the CSS source. It will be
             *                    created if `from` option is not provided
             *                    (because PostCSS does not know the file path).
             *
             * @example
             * const root = postcss.parse(css);
             * root.source.input.file //=> undefined
             * root.source.input.id   //=> "<input css 1>"
             */
            this.id = '<input css ' + sequence + '>';
        }
        if (this.map) this.map.file = this.from;
    }

    Input.prototype.error = function error(message, line, column) {
        var opts = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : {};

        var result = void 0;
        var origin = this.origin(line, column);
        if (origin) {
            result = new _cssSyntaxError2.default(message, origin.line, origin.column, origin.source, origin.file, opts.plugin);
        } else {
            result = new _cssSyntaxError2.default(message, line, column, this.css, this.file, opts.plugin);
        }

        result.input = { line: line, column: column, source: this.css };
        if (this.file) result.input.file = this.file;

        return result;
    };

    /**
     * Reads the input source map and returns a symbol position
     * in the input source (e.g., in a Sass file that was compiled
     * to CSS before being passed to PostCSS).
     *
     * @param {number} line   - line in input CSS
     * @param {number} column - column in input CSS
     *
     * @return {filePosition} position in input source
     *
     * @example
     * root.source.input.origin(1, 1) //=> { file: 'a.css', line: 3, column: 1 }
     */


    Input.prototype.origin = function origin(line, column) {
        if (!this.map) return false;
        var consumer = this.map.consumer();

        var from = consumer.originalPositionFor({ line: line, column: column });
        if (!from.source) return false;

        var result = {
            file: this.mapResolve(from.source),
            line: from.line,
            column: from.column
        };

        var source = consumer.sourceContentFor(from.source);
        if (source) result.source = source;

        return result;
    };

    Input.prototype.mapResolve = function mapResolve(file) {
        if (/^\w+:\/\//.test(file)) {
            return file;
        } else {
            return _path2.default.resolve(this.map.consumer().sourceRoot || '.', file);
        }
    };

    /**
     * The CSS source identifier. Contains {@link Input#file} if the user
     * set the `from` option, or {@link Input#id} if they did not.
     * @type {string}
     *
     * @example
     * const root = postcss.parse(css, { from: 'a.css' });
     * root.source.input.from //=> "/home/ai/a.css"
     *
     * const root = postcss.parse(css);
     * root.source.input.from //=> "<input css 1>"
     */


    _createClass(Input, [{
        key: 'from',
        get: function get() {
            return this.file || this.id;
        }
    }]);

    return Input;
}();

exports.default = Input;

/**
 * @typedef  {object} filePosition
 * @property {string} file   - path to file
 * @property {number} line   - source line in file
 * @property {number} column - source column in file
 */

module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvaW5wdXQuZXM2Il0sIm5hbWVzIjpbInNlcXVlbmNlIiwiSW5wdXQiLCJjc3MiLCJvcHRzIiwidG9TdHJpbmciLCJzbGljZSIsImZyb20iLCJ0ZXN0IiwiZmlsZSIsInJlc29sdmUiLCJtYXAiLCJ0ZXh0IiwiY29uc3VtZXIiLCJtYXBSZXNvbHZlIiwiaWQiLCJlcnJvciIsIm1lc3NhZ2UiLCJsaW5lIiwiY29sdW1uIiwicmVzdWx0Iiwib3JpZ2luIiwic291cmNlIiwicGx1Z2luIiwiaW5wdXQiLCJvcmlnaW5hbFBvc2l0aW9uRm9yIiwic291cmNlQ29udGVudEZvciIsInNvdXJjZVJvb3QiXSwibWFwcGluZ3MiOiI7Ozs7OztBQUFBOzs7O0FBQ0E7Ozs7QUFFQTs7Ozs7Ozs7QUFFQSxJQUFJQSxXQUFXLENBQWY7O0FBRUE7Ozs7Ozs7O0lBT01DLEs7O0FBRUY7Ozs7QUFJQSxtQkFBWUMsR0FBWixFQUE2QjtBQUFBLFlBQVpDLElBQVksdUVBQUwsRUFBSzs7QUFBQTs7QUFDekI7Ozs7Ozs7QUFPQSxhQUFLRCxHQUFMLEdBQVdBLElBQUlFLFFBQUosRUFBWDs7QUFFQSxZQUFLLEtBQUtGLEdBQUwsQ0FBUyxDQUFULE1BQWdCLFFBQWhCLElBQTRCLEtBQUtBLEdBQUwsQ0FBUyxDQUFULE1BQWdCLFFBQWpELEVBQTREO0FBQ3hELGlCQUFLQSxHQUFMLEdBQVcsS0FBS0EsR0FBTCxDQUFTRyxLQUFULENBQWUsQ0FBZixDQUFYO0FBQ0g7O0FBRUQsWUFBS0YsS0FBS0csSUFBVixFQUFpQjtBQUNiLGdCQUFLLFlBQVlDLElBQVosQ0FBaUJKLEtBQUtHLElBQXRCLENBQUwsRUFBbUM7QUFDL0I7Ozs7Ozs7O0FBUUEscUJBQUtFLElBQUwsR0FBWUwsS0FBS0csSUFBakI7QUFDSCxhQVZELE1BVU87QUFDSCxxQkFBS0UsSUFBTCxHQUFZLGVBQUtDLE9BQUwsQ0FBYU4sS0FBS0csSUFBbEIsQ0FBWjtBQUNIO0FBQ0o7O0FBRUQsWUFBSUksTUFBTSwwQkFBZ0Is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ZiIsImZpbGUiOiJpbnB1dC5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBDc3NTeW50YXhFcnJvciBmcm9tICcuL2Nzcy1zeW50YXgtZXJyb3InO1xuaW1wb3J0IFByZXZpb3VzTWFwICAgIGZyb20gJy4vcHJldmlvdXMtbWFwJztcblxuaW1wb3J0IHBhdGggZnJvbSAncGF0aCc7XG5cbmxldCBzZXF1ZW5jZSA9IDA7XG5cbi8qKlxuICogUmVwcmVzZW50cyB0aGUgc291cmNlIENTUy5cbiAqXG4gKiBAZXhhbXBsZVxuICogY29uc3Qgcm9vdCAgPSBwb3N0Y3NzLnBhcnNlKGNzcywgeyBmcm9tOiBmaWxlIH0pO1xuICogY29uc3QgaW5wdXQgPSByb290LnNvdXJjZS5pbnB1dDtcbiAqL1xuY2xhc3MgSW5wdXQge1xuXG4gICAgLyoqXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IGNzcyAgICAtIGlucHV0IENTUyBzb3VyY2VcbiAgICAgKiBAcGFyYW0ge29iamVjdH0gW29wdHNdIC0ge0BsaW5rIFByb2Nlc3NvciNwcm9jZXNzfSBvcHRpb25zXG4gICAgICovXG4gICAgY29uc3RydWN0b3IoY3NzLCBvcHRzID0geyB9KSB7XG4gICAgICAgIC8qKlxuICAgICAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IC0gaW5wdXQgQ1NTIHNvdXJjZVxuICAgICAgICAgKlxuICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgKiBjb25zdCBpbnB1dCA9IHBvc3Rjc3MucGFyc2UoJ2F7fScsIHsgZnJvbTogZmlsZSB9KS5pbnB1dDtcbiAgICAgICAgICogaW5wdXQuY3NzIC8vPT4gXCJhe31cIjtcbiAgICAgICAgICovXG4gICAgICAgIHRoaXMuY3NzID0gY3NzLnRvU3RyaW5nKCk7XG5cbiAgICAgICAgaWYgKCB0aGlzLmNzc1swXSA9PT0gJ1xcdUZFRkYnIHx8IHRoaXMuY3NzWzBdID09PSAnXFx1RkZGRScgKSB7XG4gICAgICAgICAgICB0aGlzLmNzcyA9IHRoaXMuY3NzLnNsaWNlKDEpO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKCBvcHRzLmZyb20gKSB7XG4gICAgICAgICAgICBpZiAoIC9eXFx3KzpcXC9cXC8vLnRlc3Qob3B0cy5mcm9tKSApIHtcbiAgICAgICAgICAgICAgICAvKipcbiAgICAgICAgICAgICAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IC0gVGhlIGFic29sdXRlIHBhdGggdG8gdGhlIENTUyBzb3VyY2UgZmlsZVxuICAgICAgICAgICAgICAgICAqICAgICAgICAgICAgICAgICAgICBkZWZpbmVkIHdpdGggdGhlIGBmcm9tYCBvcHRpb24uXG4gICAgICAgICAgICAgICAgICpcbiAgICAgICAgICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgICAgICAgICAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKGNzcywgeyBmcm9tOiAnYS5jc3MnIH0pO1xuICAgICAgICAgICAgICAgICAqIHJvb3Quc291cmNlLmlucHV0LmZpbGUgLy89PiAnL2hvbWUvYWkvYS5jc3MnXG4gICAgICAgICAgICAgICAgICovXG4gICAgICAgICAgICAgICAgdGhpcy5maWxlID0gb3B0cy5mcm9tO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICB0aGlzLmZpbGUgPSBwYXRoLnJlc29sdmUob3B0cy5mcm9tKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuXG4gICAgICAgIGxldCBtYXAgPSBuZXcgUHJldmlvdXNNYXAodGhpcy5jc3MsIG9wdHMpO1xuICAgICAgICBpZiAoIG1hcC50ZXh0ICkge1xuICAgICAgICAgICAgLyoqXG4gICAgICAgICAgICAgKiBAbWVtYmVyIHtQcmV2aW91c01hcH0gLSBUaGUgaW5wdXQgc291cmNlIG1hcCBwYXNzZWQgZnJvbVxuICAgICAgICAgICAgICogICAgICAgICAgICAgICAgICAgICAgICAgYSBjb21waWxhdGlvbiBzdGVwIGJlZm9yZSBQb3N0Q1NTXG4gICAgICAgICAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAoZm9yIGV4YW1wbGUsIGZyb20gU2FzcyBjb21waWxlcikuXG4gICAgICAgICAgICAgKlxuICAgICAgICAgICAgICogQGV4YW1wbGVcbiAgICAgICAgICAgICAqIHJvb3Quc291cmNlLmlucHV0Lm1hcC5jb25zdW1lcigpLnNvdXJjZXMgLy89PiBbJ2Euc2FzcyddXG4gICAgICAgICAgICAgKi9cbiAgICAgICAgICAgIHRoaXMubWFwID0gbWFwO1xuICAgICAgICAgICAgbGV0IGZpbGUgPSBtYXAuY29uc3VtZXIoKS5maWxlO1xuICAgICAgICAgICAgaWYgKCAhdGhpcy5maWxlICYmIGZpbGUgKSB0aGlzLmZpbGUgPSB0aGlzLm1hcFJlc29sdmUoZmlsZSk7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoICF0aGlzLmZpbGUgKSB7XG4gICAgICAgICAgICBzZXF1ZW5jZSArPSAxO1xuICAgICAgICAgICAgLyoqXG4gICAgICAgICAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IC0gVGhlIHVuaXF1ZSBJRCBvZiB0aGUgQ1NTIHNvdXJjZS4gSXQgd2lsbCBiZVxuICAgICAgICAgICAgICogICAgICAgICAgICAgICAgICAgIGNyZWF0ZWQgaWYgYGZyb21gIG9wdGlvbiBpcyBub3QgcHJvdmlkZWRcbiAgICAgICAgICAgICAqICAgICAgICAgICAgICAgICAgICAoYmVjYXVzZSBQb3N0Q1NTIGRvZXMgbm90IGtub3cgdGhlIGZpbGUgcGF0aCkuXG4gICAgICAgICAgICAgKlxuICAgICAgICAgICAgICogQGV4YW1wbGVcbiAgICAgICAgICAgICAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKGNzcyk7XG4gICAgICAgICAgICAgKiByb290LnNvdXJjZS5pbnB1dC5maWxlIC8vPT4gdW5kZWZpbmVkXG4gICAgICAgICAgICAgKiByb290LnNvdXJjZS5pbnB1dC5pZCAgIC8vPT4gXCI8aW5wdXQgY3NzIDE+XCJcbiAgICAgICAgICAgICAqL1xuICAgICAgICAgICAgdGhpcy5pZCAgID0gJzxpbnB1dCBjc3MgJyArIHNlcXVlbmNlICsgJz4nO1xuICAgICAgICB9XG4gICAgICAgIGlmICggdGhpcy5tYXAgKSB0aGlzLm1hcC5maWxlID0gdGhpcy5mcm9tO1xuICAgIH1cblxuICAgIGVycm9yKG1lc3NhZ2UsIGxpbmUsIGNvbHVtbiwgb3B0cyA9IHsgfSkge1xuICAgICAgICBsZXQgcmVzdWx0O1xuICAgICAgICBsZXQgb3JpZ2luID0gdGhpcy5vcmlnaW4obGluZSwgY29sdW1uKTtcbiAgICAgICAgaWYgKCBvcmlnaW4gKSB7XG4gICAgICAgICAgICByZXN1bHQgPSBuZXcgQ3NzU3ludGF4RXJyb3IobWVzc2FnZSwgb3JpZ2luLmxpbmUsIG9yaWdpbi5jb2x1bW4sXG4gICAgICAgICAgICAgICAgb3JpZ2luLnNvdXJjZSwgb3JpZ2luLmZpbGUsIG9wdHMucGx1Z2luKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJlc3VsdCA9IG5ldyBDc3NTeW50YXhFcnJvcihtZXNzYWdlLCBsaW5lLCBjb2x1bW4sXG4gICAgICAgICAgICAgICAgdGhpcy5jc3MsIHRoaXMuZmlsZSwgb3B0cy5wbHVnaW4pO1xuICAgICAgICB9XG5cbiAgICAgICAgcmVzdWx0LmlucHV0ID0geyBsaW5lLCBjb2x1bW4sIHNvdXJjZTogdGhpcy5jc3MgfTtcbiAgICAgICAgaWYgKCB0aGlzLmZpbGUgKSByZXN1bHQuaW5wdXQuZmlsZSA9IHRoaXMuZmlsZTtcblxuICAgICAgICByZXR1cm4gcmVzdWx0O1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIFJlYWRzIHRoZSBpbnB1dCBzb3VyY2UgbWFwIGFuZCByZXR1cm5zIGEgc3ltYm9sIHBvc2l0aW9uXG4gICAgICogaW4gdGhlIGlucHV0IHNvdXJjZSAoZS5nLiwgaW4gYSBTYXNzIGZpbGUgdGhhdCB3YXMgY29tcGlsZWRcbiAgICAgKiB0byBDU1MgYmVmb3JlIGJlaW5nIHBhc3NlZCB0byBQb3N0Q1NTKS5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7bnVtYmVyfSBsaW5lICAgLSBsaW5lIGluIGlucHV0IENTU1xuICAgICAqIEBwYXJhbSB7bnVtYmVyfSBjb2x1bW4gLSBjb2x1bW4gaW4gaW5wdXQgQ1NTXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtmaWxlUG9zaXRpb259IHBvc2l0aW9uIGluIGlucHV0IHNvdXJjZVxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiByb290LnNvdXJjZS5pbnB1dC5vcmlnaW4oMSwgMSkgLy89PiB7IGZpbGU6ICdhLmNzcycsIGxpbmU6IDMsIGNvbHVtbjogMSB9XG4gICAgICovXG4gICAgb3JpZ2luKGxpbmUsIGNvbHVtbikge1xuICAgICAgICBpZiAoICF0aGlzLm1hcCApIHJldHVybiBmYWxzZTtcbiAgICAgICAgbGV0IGNvbnN1bWVyID0gdGhpcy5tYXAuY29uc3VtZXIoKTtcblxuICAgICAgICBsZXQgZnJvbSA9IGNvbnN1bWVyLm9yaWdpbmFsUG9zaXRpb25Gb3IoeyBsaW5lLCBjb2x1bW4gfSk7XG4gICAgICAgIGlmICggIWZyb20uc291cmNlICkgcmV0dXJuIGZhbHNlO1xuXG4gICAgICAgIGxldCByZXN1bHQgPSB7XG4gICAgICAgICAgICBmaWxlOiAgIHRoaXMubWFwUmVzb2x2ZShmcm9tLnNvdXJjZSksXG4gICAgICAgICAgICBsaW5lOiAgIGZyb20ubGluZSxcbiAgICAgICAgICAgIGNvbHVtbjogZnJvbS5jb2x1bW5cbiAgICAgICAgfTtcblxuICAgICAgICBsZXQgc291cmNlID0gY29uc3VtZXIuc291cmNlQ29udGVudEZvcihmcm9tLnNvdXJjZSk7XG4gICAgICAgIGlmICggc291cmNlICkgcmVzdWx0LnNvdXJjZSA9IHNvdXJjZTtcblxuICAgICAgICByZXR1cm4gcmVzdWx0O1xuICAgIH1cblxuICAgIG1hcFJlc29sdmUoZmlsZSkge1xuICAgICAgICBpZiAoIC9eXFx3KzpcXC9cXC8vLnRlc3QoZmlsZSkgKSB7XG4gICAgICAgICAgICByZXR1cm4gZmlsZTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiBwYXRoLnJlc29sdmUodGhpcy5tYXAuY29uc3VtZXIoKS5zb3VyY2VSb290IHx8ICcuJywgZmlsZSk7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBUaGUgQ1NTIHNvdXJjZSBpZGVudGlmaWVyLiBDb250YWlucyB7QGxpbmsgSW5wdXQjZmlsZX0gaWYgdGhlIHVzZXJcbiAgICAgKiBzZXQgdGhlIGBmcm9tYCBvcHRpb24sIG9yIHtAbGluayBJbnB1dCNpZH0gaWYgdGhleSBkaWQgbm90LlxuICAgICAqIEB0eXBlIHtzdHJpbmd9XG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKGNzcywgeyBmcm9tOiAnYS5jc3MnIH0pO1xuICAgICAqIHJvb3Quc291cmNlLmlucHV0LmZyb20gLy89PiBcIi9ob21lL2FpL2EuY3NzXCJcbiAgICAgKlxuICAgICAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKGNzcyk7XG4gICAgICogcm9vdC5zb3VyY2UuaW5wdXQuZnJvbSAvLz0+IFwiPGlucHV0IGNzcyAxPlwiXG4gICAgICovXG4gICAgZ2V0IGZyb20oKSB7XG4gICAgICAgIHJldHVybiB0aGlzLmZpbGUgfHwgdGhpcy5pZDtcbiAgICB9XG5cbn1cblxuZXhwb3J0IGRlZmF1bHQgSW5wdXQ7XG5cbi8qKlxuICogQHR5cGVkZWYgIHtvYmplY3R9IGZpbGVQb3NpdGlvblxuICogQHByb3BlcnR5IHtzdHJpbmd9IGZpbGUgICAtIHBhdGggdG8gZmlsZVxuICogQHByb3BlcnR5IHtudW1iZXJ9IGxpbmUgICAtIHNvdXJjZSBsaW5lIGluIGZpbGVcbiAqIEBwcm9wZXJ0eSB7bnVtYmVyfSBjb2x1bW4gLSBzb3VyY2UgY29sdW1uIGluIGZpbGVcbiAqL1xuIl19
