'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

var _mapGenerator = require('./map-generator');

var _mapGenerator2 = _interopRequireDefault(_mapGenerator);

var _stringify2 = require('./stringify');

var _stringify3 = _interopRequireDefault(_stringify2);

var _warnOnce = require('./warn-once');

var _warnOnce2 = _interopRequireDefault(_warnOnce);

var _result = require('./result');

var _result2 = _interopRequireDefault(_result);

var _parse = require('./parse');

var _parse2 = _interopRequireDefault(_parse);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function isPromise(obj) {
    return (typeof obj === 'undefined' ? 'undefined' : _typeof(obj)) === 'object' && typeof obj.then === 'function';
}

/**
 * A Promise proxy for the result of PostCSS transformations.
 *
 * A `LazyResult` instance is returned by {@link Processor#process}.
 *
 * @example
 * const lazy = postcss([cssnext]).process(css);
 */

var LazyResult = function () {
    function LazyResult(processor, css, opts) {
        _classCallCheck(this, LazyResult);

        this.stringified = false;
        this.processed = false;

        var root = void 0;
        if ((typeof css === 'undefined' ? 'undefined' : _typeof(css)) === 'object' && css.type === 'root') {
            root = css;
        } else if (css instanceof LazyResult || css instanceof _result2.default) {
            root = css.root;
            if (css.map) {
                if (typeof opts.map === 'undefined') opts.map = {};
                if (!opts.map.inline) opts.map.inline = false;
                opts.map.prev = css.map;
            }
        } else {
            var parser = _parse2.default;
            if (opts.syntax) parser = opts.syntax.parse;
            if (opts.parser) parser = opts.parser;
            if (parser.parse) parser = parser.parse;

            try {
                root = parser(css, opts);
            } catch (error) {
                this.error = error;
            }
        }

        this.result = new _result2.default(processor, root, opts);
    }

    /**
     * Returns a {@link Processor} instance, which will be used
     * for CSS transformations.
     * @type {Processor}
     */


    /**
     * Processes input CSS through synchronous plugins
     * and calls {@link Result#warnings()}.
     *
     * @return {Warning[]} warnings from plugins
     */
    LazyResult.prototype.warnings = function warnings() {
        return this.sync().warnings();
    };

    /**
     * Alias for the {@link LazyResult#css} property.
     *
     * @example
     * lazy + '' === lazy.css;
     *
     * @return {string} output CSS
     */


    LazyResult.prototype.toString = function toString() {
        return this.css;
    };

    /**
     * Processes input CSS through synchronous and asynchronous plugins
     * and calls `onFulfilled` with a Result instance. If a plugin throws
     * an error, the `onRejected` callback will be executed.
     *
     * It implements standard Promise API.
     *
     * @param {onFulfilled} onFulfilled - callback will be executed
     *                                    when all plugins will finish work
     * @param {onRejected}  onRejected  - callback will be executed on any error
     *
     * @return {Promise} Promise API to make queue
     *
     * @example
     * postcss([cssnext]).process(css).then(result => {
     *   console.log(result.css);
     * });
     */


    LazyResult.prototype.then = function then(onFulfilled, onRejected) {
        return this.async().then(onFulfilled, onRejected);
    };

    /**
     * Processes input CSS through synchronous and asynchronous plugins
     * and calls onRejected for each error thrown in any plugin.
     *
     * It implements standard Promise API.
     *
     * @param {onRejected} onRejected - callback will be executed on any error
     *
     * @return {Promise} Promise API to make queue
     *
     * @example
     * postcss([cssnext]).process(css).then(result => {
     *   console.log(result.css);
     * }).catch(error => {
     *   console.error(error);
     * });
     */


    LazyResult.prototype.catch = function _catch(onRejected) {
        return this.async().catch(onRejected);
    };

    LazyResult.prototype.handleError = function handleError(error, plugin) {
        try {
            this.error = error;
            if (error.name === 'CssSyntaxError' && !error.plugin) {
                error.plugin = plugin.postcssPlugin;
                error.setMessage();
            } else if (plugin.postcssVersion) {
                var pluginName = plugin.postcssPlugin;
                var pluginVer = plugin.postcssVersion;
                var runtimeVer = this.result.processor.version;
                var a = pluginVer.split('.');
                var b = runtimeVer.split('.');

                if (a[0] !== b[0] || parseInt(a[1]) > parseInt(b[1])) {
                    (0, _warnOnce2.default)('Your current PostCSS version ' + 'is ' + runtimeVer + ', but ' + pluginName + ' ' + 'uses ' + pluginVer + '. Perhaps this is ' + 'the source of the error below.');
                }
            }
        } catch (err) {
            if (console && console.error) console.error(err);
        }
    };

    LazyResult.prototype.asyncTick = function asyncTick(resolve, reject) {
        var _this = this;

        if (this.plugin >= this.processor.plugins.length) {
            this.processed = true;
            return resolve();
        }

        try {
            (function () {
                var plugin = _this.processor.plugins[_this.plugin];
                var promise = _this.run(plugin);
                _this.plugin += 1;

                if (isPromise(promise)) {
                    promise.then(function () {
                        _this.asyncTick(resolve, reject);
                    }).catch(function (error) {
                        _this.handleError(error, plugin);
                        _this.processed = true;
                        reject(error);
                    });
                } else {
                    _this.asyncTick(resolve, reject);
                }
            })();
        } catch (error) {
            this.processed = true;
            reject(error);
        }
    };

    LazyResult.prototype.async = function async() {
        var _this2 = this;

        if (this.processed) {
            return new Promise(function (resolve, reject) {
                if (_this2.error) {
                    reject(_this2.error);
                } else {
                    resolve(_this2.stringify());
                }
            });
        }
        if (this.processing) {
            return this.processing;
        }

        this.processing = new Promise(function (resolve, reject) {
            if (_this2.error) return reject(_this2.error);
            _this2.plugin = 0;
            _this2.asyncTick(resolve, reject);
        }).then(function () {
            _this2.processed = true;
            return _this2.stringify();
        });

        return this.processing;
    };

    LazyResult.prototype.sync = function sync() {
        if (this.processed) return this.result;
        this.processed = true;

        if (this.processing) {
            throw new Error('Use process(css).then(cb) to work with async plugins');
        }

        if (this.error) throw this.error;

        for (var _iterator = this.result.processor.plugins, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
            var _ref;

            if (_isArray) {
                if (_i >= _iterator.length) break;
                _ref = _iterator[_i++];
            } else {
                _i = _iterator.next();
                if (_i.done) break;
                _ref = _i.value;
            }

            var plugin = _ref;

            var promise = this.run(plugin);
            if (isPromise(promise)) {
                throw new Error('Use process(css).then(cb) to work with async plugins');
            }
        }

        return this.result;
    };

    LazyResult.prototype.run = function run(plugin) {
        this.result.lastPlugin = plugin;

        try {
            return plugin(this.result.root, this.result);
        } catch (error) {
            this.handleError(error, plugin);
            throw error;
        }
    };

    LazyResult.prototype.stringify = function stringify() {
        if (this.stringified) return this.result;
        this.stringified = true;

        this.sync();

        var opts = this.result.opts;
        var str = _stringify3.default;
        if (opts.syntax) str = opts.syntax.stringify;
        if (opts.stringifier) str = opts.stringifier;
        if (str.stringify) str = str.stringify;

        var map = new _mapGenerator2.default(str, this.result.root, this.result.opts);
        var data = map.generate();
        this.result.css = data[0];
        this.result.map = data[1];

        return this.result;
    };

    _createClass(LazyResult, [{
        key: 'processor',
        get: function get() {
            return this.result.processor;
        }

        /**
         * Options from the {@link Processor#process} call.
         * @type {processOptions}
         */

    }, {
        key: 'opts',
        get: function get() {
            return this.result.opts;
        }

        /**
         * Processes input CSS through synchronous plugins, converts `Root`
         * to a CSS string and returns {@link Result#css}.
         *
         * This property will only work with synchronous plugins.
         * If the processor contains any asynchronous plugins
         * it will throw an error. This is why this method is only
         * for debug purpose, you should always use {@link LazyResult#then}.
         *
         * @type {string}
         * @see Result#css
         */

    }, {
        key: 'css',
        get: function get() {
            return this.stringify().css;
        }

        /**
         * An alias for the `css` property. Use it with syntaxes
         * that generate non-CSS output.
         *
         * This property will only work with synchronous plugins.
         * If the processor contains any asynchronous plugins
         * it will throw an error. This is why this method is only
         * for debug purpose, you should always use {@link LazyResult#then}.
         *
         * @type {string}
         * @see Result#content
         */

    }, {
        key: 'content',
        get: function get() {
            return this.stringify().content;
        }

        /**
         * Processes input CSS through synchronous plugins
         * and returns {@link Result#map}.
         *
         * This property will only work with synchronous plugins.
         * If the processor contains any asynchronous plugins
         * it will throw an error. This is why this method is only
         * for debug purpose, you should always use {@link LazyResult#then}.
         *
         * @type {SourceMapGenerator}
         * @see Result#map
         */

    }, {
        key: 'map',
        get: function get() {
            return this.stringify().map;
        }

        /**
         * Processes input CSS through synchronous plugins
         * and returns {@link Result#root}.
         *
         * This property will only work with synchronous plugins. If the processor
         * contains any asynchronous plugins it will throw an error.
         *
         * This is why this method is only for debug purpose,
         * you should always use {@link LazyResult#then}.
         *
         * @type {Root}
         * @see Result#root
         */

    }, {
        key: 'root',
        get: function get() {
            return this.sync().root;
        }

        /**
         * Processes input CSS through synchronous plugins
         * and returns {@link Result#messages}.
         *
         * This property will only work with synchronous plugins. If the processor
         * contains any asynchronous plugins it will throw an error.
         *
         * This is why this method is only for debug purpose,
         * you should always use {@link LazyResult#then}.
         *
         * @type {Message[]}
         * @see Result#messages
         */

    }, {
        key: 'messages',
        get: function get() {
            return this.sync().messages;
        }
    }]);

    return LazyResult;
}();

exports.default = LazyResult;

/**
 * @callback onFulfilled
 * @param {Result} result
 */

/**
 * @callback onRejected
 * @param {Error} error
 */

module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvbGF6eS1yZXN1bHQuZXM2Il0sIm5hbWVzIjpbImlzUHJvbWlzZSIsIm9iaiIsInRoZW4iLCJMYXp5UmVzdWx0IiwicHJvY2Vzc29yIiwiY3NzIiwib3B0cyIsInN0cmluZ2lmaWVkIiwicHJvY2Vzc2VkIiwicm9vdCIsInR5cGUiLCJtYXAiLCJpbmxpbmUiLCJwcmV2IiwicGFyc2VyIiwic3ludGF4IiwicGFyc2UiLCJlcnJvciIsInJlc3VsdCIsIndhcm5pbmdzIiwic3luYyIsInRvU3RyaW5nIiwib25GdWxmaWxsZWQiLCJvblJlamVjdGVkIiwiYXN5bmMiLCJjYXRjaCIsImhhbmRsZUVycm9yIiwicGx1Z2luIiwibmFtZSIsInBvc3Rjc3NQbHVnaW4iLCJzZXRNZXNzYWdlIiwicG9zdGNzc1ZlcnNpb24iLCJwbHVnaW5OYW1lIiwicGx1Z2luVmVyIiwicnVudGltZVZlciIsInZlcnNpb24iLCJhIiwic3BsaXQiLCJiIiwicGFyc2VJbnQiLCJlcnIiLCJjb25zb2xlIiwiYXN5bmNUaWNrIiwicmVzb2x2ZSIsInJlamVjdCIsInBsdWdpbnMiLCJsZW5ndGgiLCJwcm9taXNlIiwicnVuIiwiUHJvbWlzZSIsInN0cmluZ2lmeSIsInByb2Nlc3NpbmciLCJFcnJvciIsImxhc3RQbHVnaW4iLCJzdHIiLCJzdHJpbmdpZmllciIsImRhdGEiLCJnZW5lcmF0ZSIsImNvbnRlbnQiLCJtZXNzYWdlcyJdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7QUFBQTs7OztBQUNBOzs7O0FBQ0E7Ozs7QUFDQTs7OztBQUNBOzs7Ozs7OztBQUVBLFNBQVNBLFNBQVQsQ0FBbUJDLEdBQW5CLEVBQXdCO0FBQ3BCLFdBQU8sUUFBT0EsR0FBUCx5Q0FBT0EsR0FBUCxPQUFlLFFBQWYsSUFBMkIsT0FBT0EsSUFBSUMsSUFBWCxLQUFvQixVQUF0RDtBQUNIOztBQUVEOzs7Ozs7Ozs7SUFRTUMsVTtBQUVGLHdCQUFZQyxTQUFaLEVBQXVCQyxHQUF2QixFQUE0QkMsSUFBNUIsRUFBa0M7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LEVBQXdDLEtBQUtTLE1BQUwsQ0FBWVosSUFBcEQsQ0FBWDtBQUNBLFlBQUlrRCxPQUFPN0MsSUFBSThDLFFBQUosRUFBWDtBQUNBLGFBQUt2QyxNQUFMLENBQVliLEdBQVosR0FBa0JtRCxLQUFLLENBQUwsQ0FBbEI7QUFDQSxhQUFLdEMsTUFBTCxDQUFZUCxHQUFaLEdBQWtCNkMsS0FBSyxDQUFMLENBQWxCOztBQUVBLGVBQU8sS0FBS3RDLE1BQVo7QUFDSCxLOzs7OzRCQWxTZTtBQUNaLG1CQUFPLEtBQUtBLE1BQUwsQ0FBWWQsU0FBbkI7QUFDSDs7QUFFRDs7Ozs7Ozs0QkFJVztBQUNQLG1CQUFPLEtBQUtjLE1BQUwsQ0FBWVosSUFBbkI7QUFDSDs7QUFFRDs7Ozs7Ozs7Ozs7Ozs7OzRCQVlVO0FBQ04sbUJBQU8sS0FBSzRDLFNBQUwsR0FBaUI3QyxHQUF4QjtBQUNIOztBQUVEOzs7Ozs7Ozs7Ozs7Ozs7NEJBWWM7QUFDVixtQkFBTyxLQUFLNkMsU0FBTCxHQUFpQlEsT0FBeEI7QUFDSDs7QUFFRDs7Ozs7Ozs7Ozs7Ozs7OzRCQVlVO0FBQ04sbUJBQU8sS0FBS1IsU0FBTCxHQUFpQnZDLEdBQXhCO0FBQ0g7O0FBRUQ7Ozs7Ozs7Ozs7Ozs7Ozs7NEJBYVc7QUFDUCxtQkFBTyxLQUFLUyxJQUFMLEdBQVlYLElBQW5CO0FBQ0g7O0FBRUQ7Ozs7Ozs7Ozs7Ozs7Ozs7NEJBYWU7QUFDWCxtQkFBTyxLQUFLVyxJQUFMLEdBQVl1QyxRQUFuQjtBQUNIOzs7Ozs7a0JBME1VeEQsVTs7QUFFZjs7Ozs7QUFLQSIsImZpbGUiOiJsYXp5LXJlc3VsdC5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBNYXBHZW5lcmF0b3IgZnJvbSAnLi9tYXAtZ2VuZXJhdG9yJztcbmltcG9ydCBzdHJpbmdpZnkgICAgZnJvbSAnLi9zdHJpbmdpZnknO1xuaW1wb3J0IHdhcm5PbmNlICAgICBmcm9tICcuL3dhcm4tb25jZSc7XG5pbXBvcnQgUmVzdWx0ICAgICAgIGZyb20gJy4vcmVzdWx0JztcbmltcG9ydCBwYXJzZSAgICAgICAgZnJvbSAnLi9wYXJzZSc7XG5cbmZ1bmN0aW9uIGlzUHJvbWlzZShvYmopIHtcbiAgICByZXR1cm4gdHlwZW9mIG9iaiA9PT0gJ29iamVjdCcgJiYgdHlwZW9mIG9iai50aGVuID09PSAnZnVuY3Rpb24nO1xufVxuXG4vKipcbiAqIEEgUHJvbWlzZSBwcm94eSBmb3IgdGhlIHJlc3VsdCBvZiBQb3N0Q1NTIHRyYW5zZm9ybWF0aW9ucy5cbiAqXG4gKiBBIGBMYXp5UmVzdWx0YCBpbnN0YW5jZSBpcyByZXR1cm5lZCBieSB7QGxpbmsgUHJvY2Vzc29yI3Byb2Nlc3N9LlxuICpcbiAqIEBleGFtcGxlXG4gKiBjb25zdCBsYXp5ID0gcG9zdGNzcyhbY3NzbmV4dF0pLnByb2Nlc3MoY3NzKTtcbiAqL1xuY2xhc3MgTGF6eVJlc3VsdCB7XG5cbiAgICBjb25zdHJ1Y3Rvcihwcm9jZXNzb3IsIGNzcywgb3B0cykge1xuICAgICAgICB0aGlzLnN0cmluZ2lmaWVkID0gZmFsc2U7XG4gICAgICAgIHRoaXMucHJvY2Vzc2VkICAgPSBmYWxzZTtcblxuICAgICAgICBsZXQgcm9vdDtcbiAgICAgICAgaWYgKCB0eXBlb2YgY3NzID09PSAnb2JqZWN0JyAmJiBjc3MudHlwZSA9PT0gJ3Jvb3QnICkge1xuICAgICAgICAgICAgcm9vdCA9IGNzcztcbiAgICAgICAgfSBlbHNlIGlmICggY3NzIGluc3RhbmNlb2YgTGF6eVJlc3VsdCB8fCBjc3MgaW5zdGFuY2VvZiBSZXN1bHQgKSB7XG4gICAgICAgICAgICByb290ID0gY3NzLnJvb3Q7XG4gICAgICAgICAgICBpZiAoIGNzcy5tYXAgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCB0eXBlb2Ygb3B0cy5tYXAgPT09ICd1bmRlZmluZWQnICkgb3B0cy5tYXAgPSB7IH07XG4gICAgICAgICAgICAgICAgaWYgKCAhb3B0cy5tYXAuaW5saW5lICkgb3B0cy5tYXAuaW5saW5lID0gZmFsc2U7XG4gICAgICAgICAgICAgICAgb3B0cy5tYXAucHJldiA9IGNzcy5tYXA7XG4gICAgICAgICAgICB9XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICBsZXQgcGFyc2VyID0gcGFyc2U7XG4gICAgICAgICAgICBpZiAoIG9wdHMuc3ludGF4ICkgIHBhcnNlciA9IG9wdHMuc3ludGF4LnBhcnNlO1xuICAgICAgICAgICAgaWYgKCBvcHRzLnBhcnNlciApICBwYXJzZXIgPSBvcHRzLnBhcnNlcjtcbiAgICAgICAgICAgIGlmICggcGFyc2VyLnBhcnNlICkgcGFyc2VyID0gcGFyc2VyLnBhcnNlO1xuXG4gICAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgICAgIHJvb3QgPSBwYXJzZXIoY3NzLCBvcHRzKTtcbiAgICAgICAgICAgIH0gY2F0Y2ggKGVycm9yKSB7XG4gICAgICAgICAgICAgICAgdGhpcy5lcnJvciA9IGVycm9yO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG5cbiAgICAgICAgdGhpcy5yZXN1bHQgPSBuZXcgUmVzdWx0KHByb2Nlc3Nvciwgcm9vdCwgb3B0cyk7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUmV0dXJucyBhIHtAbGluayBQcm9jZXNzb3J9IGluc3RhbmNlLCB3aGljaCB3aWxsIGJlIHVzZWRcbiAgICAgKiBmb3IgQ1NTIHRyYW5zZm9ybWF0aW9ucy5cbiAgICAgKiBAdHlwZSB7UHJvY2Vzc29yfVxuICAgICAqL1xuICAgIGdldCBwcm9jZXNzb3IoKSB7XG4gICAgICAgIHJldHVybiB0aGlzLnJlc3VsdC5wcm9jZXNzb3I7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogT3B0aW9ucyBmcm9tIHRoZSB7QGxpbmsgUHJvY2Vzc29yI3Byb2Nlc3N9IGNhbGwuXG4gICAgICogQHR5cGUge3Byb2Nlc3NPcHRpb25zfVxuICAgICAqL1xuICAgIGdldCBvcHRzKCkge1xuICAgICAgICByZXR1cm4gdGhpcy5yZXN1bHQub3B0cztcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBQcm9jZXNzZXMgaW5wdXQgQ1NTIHRocm91Z2ggc3luY2hyb25vdXMgcGx1Z2lucywgY29udmVydHMgYFJvb3RgXG4gICAgICogdG8gYSBDU1Mgc3RyaW5nIGFuZCByZXR1cm5zIHtAbGluayBSZXN1bHQjY3NzfS5cbiAgICAgKlxuICAgICAqIFRoaXMgcHJvcGVydHkgd2lsbCBvbmx5IHdvcmsgd2l0aCBzeW5jaHJvbm91cyBwbHVnaW5zLlxuICAgICAqIElmIHRoZSBwcm9jZXNzb3IgY29udGFpbnMgYW55IGFzeW5jaHJvbm91cyBwbHVnaW5zXG4gICAgICogaXQgd2lsbCB0aHJvdyBhbiBlcnJvci4gVGhpcyBpcyB3aHkgdGhpcyBtZXRob2QgaXMgb25seVxuICAgICAqIGZvciBkZWJ1ZyBwdXJwb3NlLCB5b3Ugc2hvdWxkIGFsd2F5cyB1c2Uge0BsaW5rIExhenlSZXN1bHQjdGhlbn0uXG4gICAgICpcbiAgICAgKiBAdHlwZSB7c3RyaW5nfVxuICAgICAqIEBzZWUgUmVzdWx0I2Nzc1xuICAgICAqL1xuICAgIGdldCBjc3MoKSB7XG4gICAgICAgIHJldHVybiB0aGlzLnN0cmluZ2lmeSgpLmNzcztcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBBbiBhbGlhcyBmb3IgdGhlIGBjc3NgIHByb3BlcnR5LiBVc2UgaXQgd2l0aCBzeW50YXhlc1xuICAgICAqIHRoYXQgZ2VuZXJhdGUgbm9uLUNTUyBvdXRwdXQuXG4gICAgICpcbiAgICAgKiBUaGlzIHByb3BlcnR5IHdpbGwgb25seSB3b3JrIHdpdGggc3luY2hyb25vdXMgcGx1Z2lucy5cbiAgICAgKiBJZiB0aGUgcHJvY2Vzc29yIGNvbnRhaW5zIGFueSBhc3luY2hyb25vdXMgcGx1Z2luc1xuICAgICAqIGl0IHdpbGwgdGhyb3cgYW4gZXJyb3IuIFRoaXMgaXMgd2h5IHRoaXMgbWV0aG9kIGlzIG9ubHlcbiAgICAgKiBmb3IgZGVidWcgcHVycG9zZSwgeW91IHNob3VsZCBhbHdheXMgdXNlIHtAbGluayBMYXp5UmVzdWx0I3RoZW59LlxuICAgICAqXG4gICAgICogQHR5cGUge3N0cmluZ31cbiAgICAgKiBAc2VlIFJlc3VsdCNjb250ZW50XG4gICAgICovXG4gICAgZ2V0IGNvbnRlbnQoKSB7XG4gICAgICAgIHJldHVybiB0aGlzLnN0cmluZ2lmeSgpLmNvbnRlbnQ7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUHJvY2Vzc2VzIGlucHV0IENTUyB0aHJvdWdoIHN5bmNocm9ub3VzIHBsdWdpbnNcbiAgICAgKiBhbmQgcmV0dXJucyB7QGxpbmsgUmVzdWx0I21hcH0uXG4gICAgICpcbiAgICAgKiBUaGlzIHByb3BlcnR5IHdpbGwgb25seSB3b3JrIHdpdGggc3luY2hyb25vdXMgcGx1Z2lucy5cbiAgICAgKiBJZiB0aGUgcHJvY2Vzc29yIGNvbnRhaW5zIGFueSBhc3luY2hyb25vdXMgcGx1Z2luc1xuICAgICAqIGl0IHdpbGwgdGhyb3cgYW4gZXJyb3IuIFRoaXMgaXMgd2h5IHRoaXMgbWV0aG9kIGlzIG9ubHlcbiAgICAgKiBmb3IgZGVidWcgcHVycG9zZSwgeW91IHNob3VsZCBhbHdheXMgdXNlIHtAbGluayBMYXp5UmVzdWx0I3RoZW59LlxuICAgICAqXG4gICAgICogQHR5cGUge1NvdXJjZU1hcEdlbmVyYXRvcn1cbiAgICAgKiBAc2VlIFJlc3VsdCNtYXBcbiAgICAgKi9cbiAgICBnZXQgbWFwKCkge1xuICAgICAgICByZXR1cm4gdGhpcy5zdHJpbmdpZnkoKS5tYXA7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUHJvY2Vzc2VzIGlucHV0IENTUyB0aHJvdWdoIHN5bmNocm9ub3VzIHBsdWdpbnNcbiAgICAgKiBhbmQgcmV0dXJucyB7QGxpbmsgUmVzdWx0I3Jvb3R9LlxuICAgICAqXG4gICAgICogVGhpcyBwcm9wZXJ0eSB3aWxsIG9ubHkgd29yayB3aXRoIHN5bmNocm9ub3VzIHBsdWdpbnMuIElmIHRoZSBwcm9jZXNzb3JcbiAgICAgKiBjb250YWlucyBhbnkgYXN5bmNocm9ub3VzIHBsdWdpbnMgaXQgd2lsbCB0aHJvdyBhbiBlcnJvci5cbiAgICAgKlxuICAgICAqIFRoaXMgaXMgd2h5IHRoaXMgbWV0aG9kIGlzIG9ubHkgZm9yIGRlYnVnIHB1cnBvc2UsXG4gICAgICogeW91IHNob3VsZCBhbHdheXMgdXNlIHtAbGluayBMYXp5UmVzdWx0I3RoZW59LlxuICAgICAqXG4gICAgICogQHR5cGUge1Jvb3R9XG4gICAgICogQHNlZSBSZXN1bHQjcm9vdFxuICAgICAqL1xuICAgIGdldCByb290KCkge1xuICAgICAgICByZXR1cm4gdGhpcy5zeW5jKCkucm9vdDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBQcm9jZXNzZXMgaW5wdXQgQ1NTIHRocm91Z2ggc3luY2hyb25vdXMgcGx1Z2luc1xuICAgICAqIGFuZCByZXR1cm5zIHtAbGluayBSZXN1bHQjbWVzc2FnZXN9LlxuICAgICAqXG4gICAgICogVGhpcyBwcm9wZXJ0eSB3aWxsIG9ubHkgd29yayB3aXRoIHN5bmNocm9ub3VzIHBsdWdpbnMuIElmIHRoZSBwcm9jZXNzb3JcbiAgICAgKiBjb250YWlucyBhbnkgYXN5bmNocm9ub3VzIHBsdWdpbnMgaXQgd2lsbCB0aHJvdyBhbiBlcnJvci5cbiAgICAgKlxuICAgICAqIFRoaXMgaXMgd2h5IHRoaXMgbWV0aG9kIGlzIG9ubHkgZm9yIGRlYnVnIHB1cnBvc2UsXG4gICAgICogeW91IHNob3VsZCBhbHdheXMgdXNlIHtAbGluayBMYXp5UmVzdWx0I3RoZW59LlxuICAgICAqXG4gICAgICogQHR5cGUge01lc3NhZ2VbXX1cbiAgICAgKiBAc2VlIFJlc3VsdCNtZXNzYWdlc1xuICAgICAqL1xuICAgIGdldCBtZXNzYWdlcygpIHtcbiAgICAgICAgcmV0dXJuIHRoaXMuc3luYygpLm1lc3NhZ2VzO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIFByb2Nlc3NlcyBpbnB1dCBDU1MgdGhyb3VnaCBzeW5jaHJvbm91cyBwbHVnaW5zXG4gICAgICogYW5kIGNhbGxzIHtAbGluayBSZXN1bHQjd2FybmluZ3MoKX0uXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtXYXJuaW5nW119IHdhcm5pbmdzIGZyb20gcGx1Z2luc1xuICAgICAqL1xuICAgIHdhcm5pbmdzKCkge1xuICAgICAgICByZXR1cm4gdGhpcy5zeW5jKCkud2FybmluZ3MoKTtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBBbGlhcyBmb3IgdGhlIHtAbGluayBMYXp5UmVzdWx0I2Nzc30gcHJvcGVydHkuXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGxhenkgKyAnJyA9PT0gbGF6eS5jc3M7XG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtzdHJpbmd9IG91dHB1dCBDU1NcbiAgICAgKi9cbiAgICB0b1N0cmluZygpIHtcbiAgICAgICAgcmV0dXJuIHRoaXMuY3NzO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIFByb2Nlc3NlcyBpbnB1dCBDU1MgdGhyb3VnaCBzeW5jaHJvbm91cyBhbmQgYXN5bmNocm9ub3VzIHBsdWdpbnNcbiAgICAgKiBhbmQgY2FsbHMgYG9uRnVsZmlsbGVkYCB3aXRoIGEgUmVzdWx0IGluc3RhbmNlLiBJZiBhIHBsdWdpbiB0aHJvd3NcbiAgICAgKiBhbiBlcnJvciwgdGhlIGBvblJlamVjdGVkYCBjYWxsYmFjayB3aWxsIGJlIGV4ZWN1dGVkLlxuICAgICAqXG4gICAgICogSXQgaW1wbGVtZW50cyBzdGFuZGFyZCBQcm9taXNlIEFQSS5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7b25GdWxmaWxsZWR9IG9uRnVsZmlsbGVkIC0gY2FsbGJhY2sgd2lsbCBiZSBleGVjdXRlZFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2hlbiBhbGwgcGx1Z2lucyB3aWxsIGZpbmlzaCB3b3JrXG4gICAgICogQHBhcmFtIHtvblJlamVjdGVkfSAgb25SZWplY3RlZCAgLSBjYWxsYmFjayB3aWxsIGJlIGV4ZWN1dGVkIG9uIGFueSBlcnJvclxuICAgICAqXG4gICAgICogQHJldHVybiB7UHJvbWlzZX0gUHJvbWlzZSBBUEkgdG8gbWFrZSBxdWV1ZVxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBwb3N0Y3NzKFtjc3NuZXh0XSkucHJvY2Vzcyhjc3MpLnRoZW4ocmVzdWx0ID0+IHtcbiAgICAgKiAgIGNvbnNvbGUubG9nKHJlc3VsdC5jc3MpO1xuICAgICAqIH0pO1xuICAgICAqL1xuICAgIHRoZW4ob25GdWxmaWxsZWQsIG9uUmVqZWN0ZWQpIHtcbiAgICAgICAgcmV0dXJuIHRoaXMuYXN5bmMoKS50aGVuKG9uRnVsZmlsbGVkLCBvblJlamVjdGVkKTtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBQcm9jZXNzZXMgaW5wdXQgQ1NTIHRocm91Z2ggc3luY2hyb25vdXMgYW5kIGFzeW5jaHJvbm91cyBwbHVnaW5zXG4gICAgICogYW5kIGNhbGxzIG9uUmVqZWN0ZWQgZm9yIGVhY2ggZXJyb3IgdGhyb3duIGluIGFueSBwbHVnaW4uXG4gICAgICpcbiAgICAgKiBJdCBpbXBsZW1lbnRzIHN0YW5kYXJkIFByb21pc2UgQVBJLlxuICAgICAqXG4gICAgICogQHBhcmFtIHtvblJlamVjdGVkfSBvblJlamVjdGVkIC0gY2FsbGJhY2sgd2lsbCBiZSBleGVjdXRlZCBvbiBhbnkgZXJyb3JcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge1Byb21pc2V9IFByb21pc2UgQVBJIHRvIG1ha2UgcXVldWVcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcG9zdGNzcyhbY3NzbmV4dF0pLnByb2Nlc3MoY3NzKS50aGVuKHJlc3VsdCA9PiB7XG4gICAgICogICBjb25zb2xlLmxvZyhyZXN1bHQuY3NzKTtcbiAgICAgKiB9KS5jYXRjaChlcnJvciA9PiB7XG4gICAgICogICBjb25zb2xlLmVycm9yKGVycm9yKTtcbiAgICAgKiB9KTtcbiAgICAgKi9cbiAgICBjYXRjaChvblJlamVjdGVkKSB7XG4gICAgICAgIHJldHVybiB0aGlzLmFzeW5jKCkuY2F0Y2gob25SZWplY3RlZCk7XG4gICAgfVxuXG4gICAgaGFuZGxlRXJyb3IoZXJyb3IsIHBsdWdpbikge1xuICAgICAgICB0cnkge1xuICAgICAgICAgICAgdGhpcy5lcnJvciA9IGVycm9yO1xuICAgICAgICAgICAgaWYgKCBlcnJvci5uYW1lID09PSAnQ3NzU3ludGF4RXJyb3InICYmICFlcnJvci5wbHVnaW4gKSB7XG4gICAgICAgICAgICAgICAgZXJyb3IucGx1Z2luID0gcGx1Z2luLnBvc3Rjc3NQbHVnaW47XG4gICAgICAgICAgICAgICAgZXJyb3Iuc2V0TWVzc2FnZSgpO1xuICAgICAgICAgICAgfSBlbHNlIGlmICggcGx1Z2luLnBvc3Rjc3NWZXJzaW9uICkge1xuICAgICAgICAgICAgICAgIGxldCBwbHVnaW5OYW1lID0gcGx1Z2luLnBvc3Rjc3NQbHVnaW47XG4gICAgICAgICAgICAgICAgbGV0IHBsdWdpblZlciAgPSBwbHVnaW4ucG9zdGNzc1ZlcnNpb247XG4gICAgICAgICAgICAgICAgbGV0IHJ1bnRpbWVWZXIgPSB0aGlzLnJlc3VsdC5wcm9jZXNzb3IudmVyc2lvbjtcbiAgICAgICAgICAgICAgICBsZXQgYSA9IHBsdWdpblZlci5zcGxpdCgnLicpO1xuICAgICAgICAgICAgICAgIGxldCBiID0gcnVudGltZVZlci5zcGxpdCgnLicpO1xuXG4gICAgICAgICAgICAgICAgaWYgKCBhWzBdICE9PSBiWzBdIHx8IHBhcnNlSW50KGFbMV0pID4gcGFyc2VJbnQoYlsxXSkgKSB7XG4gICAgICAgICAgICAgICAgICAgIHdhcm5PbmNlKCdZb3VyIGN1cnJlbnQgUG9zdENTUyB2ZXJzaW9uICcgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnaXMgJyArIHJ1bnRpbWVWZXIgKyAnLCBidXQgJyArIHBsdWdpbk5hbWUgKyAnICcgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAndXNlcyAnICsgcGx1Z2luVmVyICsgJy4gUGVyaGFwcyB0aGlzIGlzICcgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAndGhlIHNvdXJjZSBvZiB0aGUgZXJyb3IgYmVsb3cuJyk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9IGNhdGNoIChlcnIpIHtcbiAgICAgICAgICAgIGlmICggY29uc29sZSAmJiBjb25zb2xlLmVycm9yICkgY29uc29sZS5lcnJvcihlcnIpO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgYXN5bmNUaWNrKHJlc29sdmUsIHJlamVjdCkge1xuICAgICAgICBpZiAoIHRoaXMucGx1Z2luID49IHRoaXMucHJvY2Vzc29yLnBsdWdpbnMubGVuZ3RoICkge1xuICAgICAgICAgICAgdGhpcy5wcm9jZXNzZWQgPSB0cnVlO1xuICAgICAgICAgICAgcmV0dXJuIHJlc29sdmUoKTtcbiAgICAgICAgfVxuXG4gICAgICAgIHRyeSB7XG4gICAgICAgICAgICBsZXQgcGx1Z2luICA9IHRoaXMucHJvY2Vzc29yLnBsdWdpbnNbdGhpcy5wbHVnaW5dO1xuICAgICAgICAgICAgbGV0IHByb21pc2UgPSB0aGlzLnJ1bihwbHVnaW4pO1xuICAgICAgICAgICAgdGhpcy5wbHVnaW4gKz0gMTtcblxuICAgICAgICAgICAgaWYgKCBpc1Byb21pc2UocHJvbWlzZSkgKSB7XG4gICAgICAgICAgICAgICAgcHJvbWlzZS50aGVuKCAoKSA9PiB7XG4gICAgICAgICAgICAgICAgICAgIHRoaXMuYXN5bmNUaWNrKHJlc29sdmUsIHJlamVjdCk7XG4gICAgICAgICAgICAgICAgfSkuY2F0Y2goIGVycm9yID0+IHtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5oYW5kbGVFcnJvcihlcnJvciwgcGx1Z2luKTtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5wcm9jZXNzZWQgPSB0cnVlO1xuICAgICAgICAgICAgICAgICAgICByZWplY3QoZXJyb3IpO1xuICAgICAgICAgICAgICAgIH0pO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICB0aGlzLmFzeW5jVGljayhyZXNvbHZlLCByZWplY3QpO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgIH0gY2F0Y2ggKGVycm9yKSB7XG4gICAgICAgICAgICB0aGlzLnByb2Nlc3NlZCA9IHRydWU7XG4gICAgICAgICAgICByZWplY3QoZXJyb3IpO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgYXN5bmMoKSB7XG4gICAgICAgIGlmICggdGhpcy5wcm9jZXNzZWQgKSB7XG4gICAgICAgICAgICByZXR1cm4gbmV3IFByb21pc2UoIChyZXNvbHZlLCByZWplY3QpID0+IHtcbiAgICAgICAgICAgICAgICBpZiAoIHRoaXMuZXJyb3IgKSB7XG4gICAgICAgICAgICAgICAgICAgIHJlamVjdCh0aGlzLmVycm9yKTtcbiAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICByZXNvbHZlKHRoaXMuc3RyaW5naWZ5KCkpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH0pO1xuICAgICAgICB9XG4gICAgICAgIGlmICggdGhpcy5wcm9jZXNzaW5nICkge1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMucHJvY2Vzc2luZztcbiAgICAgICAgfVxuXG4gICAgICAgIHRoaXMucHJvY2Vzc2luZyA9IG5ldyBQcm9taXNlKCAocmVzb2x2ZSwgcmVqZWN0KSA9PiB7XG4gICAgICAgICAgICBpZiAoIHRoaXMuZXJyb3IgKSByZXR1cm4gcmVqZWN0KHRoaXMuZXJyb3IpO1xuICAgICAgICAgICAgdGhpcy5wbHVnaW4gPSAwO1xuICAgICAgICAgICAgdGhpcy5hc3luY1RpY2socmVzb2x2ZSwgcmVqZWN0KTtcbiAgICAgICAgfSkudGhlbiggKCkgPT4ge1xuICAgICAgICAgICAgdGhpcy5wcm9jZXNzZWQgPSB0cnVlO1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMuc3RyaW5naWZ5KCk7XG4gICAgICAgIH0pO1xuXG4gICAgICAgIHJldHVybiB0aGlzLnByb2Nlc3Npbmc7XG4gICAgfVxuXG4gICAgc3luYygpIHtcbiAgICAgICAgaWYgKCB0aGlzLnByb2Nlc3NlZCApIHJldHVybiB0aGlzLnJlc3VsdDtcbiAgICAgICAgdGhpcy5wcm9jZXNzZWQgPSB0cnVlO1xuXG4gICAgICAgIGlmICggdGhpcy5wcm9jZXNzaW5nICkge1xuICAgICAgICAgICAgdGhyb3cgbmV3IEVycm9yKFxuICAgICAgICAgICAgICAgICdVc2UgcHJvY2Vzcyhjc3MpLnRoZW4oY2IpIHRvIHdvcmsgd2l0aCBhc3luYyBwbHVnaW5zJyk7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoIHRoaXMuZXJyb3IgKSB0aHJvdyB0aGlzLmVycm9yO1xuXG4gICAgICAgIGZvciAoIGxldCBwbHVnaW4gb2YgdGhpcy5yZXN1bHQucHJvY2Vzc29yLnBsdWdpbnMgKSB7XG4gICAgICAgICAgICBsZXQgcHJvbWlzZSA9IHRoaXMucnVuKHBsdWdpbik7XG4gICAgICAgICAgICBpZiAoIGlzUHJvbWlzZShwcm9taXNlKSApIHtcbiAgICAgICAgICAgICAgICB0aHJvdyBuZXcgRXJyb3IoXG4gICAgICAgICAgICAgICAgICAgICdVc2UgcHJvY2Vzcyhjc3MpLnRoZW4oY2IpIHRvIHdvcmsgd2l0aCBhc3luYyBwbHVnaW5zJyk7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cblxuICAgICAgICByZXR1cm4gdGhpcy5yZXN1bHQ7XG4gICAgfVxuXG4gICAgcnVuKHBsdWdpbikge1xuICAgICAgICB0aGlzLnJlc3VsdC5sYXN0UGx1Z2luID0gcGx1Z2luO1xuXG4gICAgICAgIHRyeSB7XG4gICAgICAgICAgICByZXR1cm4gcGx1Z2luKHRoaXMucmVzdWx0LnJvb3QsIHRoaXMucmVzdWx0KTtcbiAgICAgICAgfSBjYXRjaCAoZXJyb3IpIHtcbiAgICAgICAgICAgIHRoaXMuaGFuZGxlRXJyb3IoZXJyb3IsIHBsdWdpbik7XG4gICAgICAgICAgICB0aHJvdyBlcnJvcjtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIHN0cmluZ2lmeSgpIHtcbiAgICAgICAgaWYgKCB0aGlzLnN0cmluZ2lmaWVkICkgcmV0dXJuIHRoaXMucmVzdWx0O1xuICAgICAgICB0aGlzLnN0cmluZ2lmaWVkID0gdHJ1ZTtcblxuICAgICAgICB0aGlzLnN5bmMoKTtcblxuICAgICAgICBsZXQgb3B0cyA9IHRoaXMucmVzdWx0Lm9wdHM7XG4gICAgICAgIGxldCBzdHIgID0gc3RyaW5naWZ5O1xuICAgICAgICBpZiAoIG9wdHMuc3ludGF4ICkgICAgICBzdHIgPSBvcHRzLnN5bnRheC5zdHJpbmdpZnk7XG4gICAgICAgIGlmICggb3B0cy5zdHJpbmdpZmllciApIHN0ciA9IG9wdHMuc3RyaW5naWZpZXI7XG4gICAgICAgIGlmICggc3RyLnN0cmluZ2lmeSApICAgIHN0ciA9IHN0ci5zdHJpbmdpZnk7XG5cbiAgICAgICAgbGV0IG1hcCAgPSBuZXcgTWFwR2VuZXJhdG9yKHN0ciwgdGhpcy5yZXN1bHQucm9vdCwgdGhpcy5yZXN1bHQub3B0cyk7XG4gICAgICAgIGxldCBkYXRhID0gbWFwLmdlbmVyYXRlKCk7XG4gICAgICAgIHRoaXMucmVzdWx0LmNzcyA9IGRhdGFbMF07XG4gICAgICAgIHRoaXMucmVzdWx0Lm1hcCA9IGRhdGFbMV07XG5cbiAgICAgICAgcmV0dXJuIHRoaXMucmVzdWx0O1xuICAgIH1cblxufVxuXG5leHBvcnQgZGVmYXVsdCBMYXp5UmVzdWx0O1xuXG4vKipcbiAqIEBjYWxsYmFjayBvbkZ1bGZpbGxlZFxuICogQHBhcmFtIHtSZXN1bHR9IHJlc3VsdFxuICovXG5cbi8qKlxuICogQGNhbGxiYWNrIG9uUmVqZWN0ZWRcbiAqIEBwYXJhbSB7RXJyb3J9IGVycm9yXG4gKi9cbiJdfQ==
