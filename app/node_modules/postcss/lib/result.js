'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _warning = require('./warning');

var _warning2 = _interopRequireDefault(_warning);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

/**
 * Provides the result of the PostCSS transformations.
 *
 * A Result instance is returned by {@link LazyResult#then}
 * or {@link Root#toResult} methods.
 *
 * @example
 * postcss([cssnext]).process(css).then(function (result) {
 *    console.log(result.css);
 * });
 *
 * @example
 * var result2 = postcss.parse(css).toResult();
 */
var Result = function () {

  /**
   * @param {Processor} processor - processor used for this transformation.
   * @param {Root}      root      - Root node after all transformations.
   * @param {processOptions} opts - options from the {@link Processor#process}
   *                                or {@link Root#toResult}
   */
  function Result(processor, root, opts) {
    _classCallCheck(this, Result);

    /**
     * @member {Processor} - The Processor instance used
     *                       for this transformation.
     *
     * @example
     * for ( let plugin of result.processor.plugins) {
     *   if ( plugin.postcssPlugin === 'postcss-bad' ) {
     *     throw 'postcss-good is incompatible with postcss-bad';
     *   }
     * });
     */
    this.processor = processor;
    /**
     * @member {Message[]} - Contains messages from plugins
     *                       (e.g., warnings or custom messages).
     *                       Each message should have type
     *                       and plugin properties.
     *
     * @example
     * postcss.plugin('postcss-min-browser', () => {
     *   return (root, result) => {
     *     var browsers = detectMinBrowsersByCanIUse(root);
     *     result.messages.push({
     *       type:    'min-browser',
     *       plugin:  'postcss-min-browser',
     *       browsers: browsers
     *     });
     *   };
     * });
     */
    this.messages = [];
    /**
     * @member {Root} - Root node after all transformations.
     *
     * @example
     * root.toResult().root == root;
     */
    this.root = root;
    /**
     * @member {processOptions} - Options from the {@link Processor#process}
     *                            or {@link Root#toResult} call
     *                            that produced this Result instance.
     *
     * @example
     * root.toResult(opts).opts == opts;
     */
    this.opts = opts;
    /**
     * @member {string} - A CSS string representing of {@link Result#root}.
     *
     * @example
     * postcss.parse('a{}').toResult().css //=> "a{}"
     */
    this.css = undefined;
    /**
     * @member {SourceMapGenerator} - An instance of `SourceMapGenerator`
     *                                class from the `source-map` library,
     *                                representing changes
     *                                to the {@link Result#root} instance.
     *
     * @example
     * result.map.toJSON() //=> { version: 3, file: 'a.css', … }
     *
     * @example
     * if ( result.map ) {
     *   fs.writeFileSync(result.opts.to + '.map', result.map.toString());
     * }
     */
    this.map = undefined;
  }

  /**
   * Returns for @{link Result#css} content.
   *
   * @example
   * result + '' === result.css
   *
   * @return {string} string representing of {@link Result#root}
   */


  Result.prototype.toString = function toString() {
    return this.css;
  };

  /**
   * Creates an instance of {@link Warning} and adds it
   * to {@link Result#messages}.
   *
   * @param {string} text        - warning message
   * @param {Object} [opts]      - warning options
   * @param {Node}   opts.node   - CSS node that caused the warning
   * @param {string} opts.word   - word in CSS source that caused the warning
   * @param {number} opts.index  - index in CSS node string that caused
   *                               the warning
   * @param {string} opts.plugin - name of the plugin that created
   *                               this warning. {@link Result#warn} fills
   *                               this property automatically.
   *
   * @return {Warning} created warning
   */


  Result.prototype.warn = function warn(text) {
    var opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    if (!opts.plugin) {
      if (this.lastPlugin && this.lastPlugin.postcssPlugin) {
        opts.plugin = this.lastPlugin.postcssPlugin;
      }
    }

    var warning = new _warning2.default(text, opts);
    this.messages.push(warning);

    return warning;
  };

  /**
   * Returns warnings from plugins. Filters {@link Warning} instances
   * from {@link Result#messages}.
   *
   * @example
   * result.warnings().forEach(warn => {
   *   console.warn(warn.toString());
   * });
   *
   * @return {Warning[]} warnings from plugins
   */


  Result.prototype.warnings = function warnings() {
    return this.messages.filter(function (i) {
      return i.type === 'warning';
    });
  };

  /**
   * An alias for the {@link Result#css} property.
   * Use it with syntaxes that generate non-CSS output.
   * @type {string}
   *
   * @example
   * result.css === result.content;
   */


  _createClass(Result, [{
    key: 'content',
    get: function get() {
      return this.css;
    }
  }]);

  return Result;
}();

exports.default = Result;

/**
 * @typedef  {object} Message
 * @property {string} type   - message type
 * @property {string} plugin - source PostCSS plugin name
 */

module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvcmVzdWx0LmVzNiJdLCJuYW1lcyI6WyJSZXN1bHQiLCJwcm9jZXNzb3IiLCJyb290Iiwib3B0cyIsIm1lc3NhZ2VzIiwiY3NzIiwidW5kZWZpbmVkIiwibWFwIiwidG9TdHJpbmciLCJ3YXJuIiwidGV4dCIsInBsdWdpbiIsImxhc3RQbHVnaW4iLCJwb3N0Y3NzUGx1Z2luIiwid2FybmluZyIsInB1c2giLCJ3YXJuaW5ncyIsImZpbHRlciIsImkiLCJ0eXBlIl0sIm1hcHBpbmdzIjoiOzs7Ozs7QUFBQTs7Ozs7Ozs7QUFFQTs7Ozs7Ozs7Ozs7Ozs7SUFjTUEsTTs7QUFFRjs7Ozs7O0FBTUEsa0JBQVlDLFNBQVosRUFBdUJDLElBQXZCLEVBQTZCQyxJQUE3QixFQUFtQztBQUFBOztBQUMvQjs7Ozs7Ozs7Ozs7QUFXQSxTQUFLRixTQUFMLEdBQWlCQSxTQUFqQjtBQUNBOzs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFrQkEsU0FBS0csUUFBTCxHQUFnQixFQUFoQjtBQUNBOzs7Ozs7QUFNQSxTQUFLRixJQUFMLEdBQVlBLElBQVo7QUFDQTs7Ozs7Ozs7QUFRQSxTQUFLQyxJQUFMLEdBQVlBLElBQVo7QUFDQTs7Ozs7O0FBTUEsU0FBS0UsR0FBTCxHQUFXQyxTQUFYO0FBQ0E7Ozs7Ozs7Ozs7Ozs7O0FBY0EsU0FBS0MsR0FBTCxHQUFXRCxTQUFYO0FBQ0g7O0FBRUQ7Ozs7Ozs7Ozs7bUJBUUFFLFEsdUJBQVc7QUFDUCxXQUFPLEtBQUtILEdBQVo7QUFDSCxHOztBQUVEOzs7Ozs7Ozs7Ozs7Ozs7Ozs7bUJBZ0JBSSxJLGlCQUFLQyxJLEVBQWtCO0FBQUEsUUFBWlAsSUFBWSx1RUFBTCxFQUFLOztBQUNuQixRQUFLLENBQUNBLEtBQUtRLE1BQVgsRUFBb0I7QUFDaEIsVUFBSyxLQUFLQyxVQUFMLElBQW1CLEtBQUtBLFVBQUwsQ0FBZ0JDLGFBQXhDLEVBQXdEO0FBQ3BEVixhQUFLUSxNQUFMLEdBQWMsS0FBS0MsVUFBTCxDQUFnQkMsYUFBOUI7QUFDSDtBQUNKOztBQUVELFFBQUlDLFVBQVUsc0JBQVlKLElBQVosRUFBa0JQLElBQWxCLENBQWQ7QUFDQSxTQUFLQyxRQUFMLENBQWNXLElBQWQsQ0FBbUJELE9BQW5COztBQUVBLFdBQU9BLE9BQVA7QUFDSCxHOztBQUVEOzs7Ozs7Ozs7Ozs7O21CQVdBRSxRLHVCQUFXO0FBQ1AsV0FBTyxLQUFLWixRQUFMLENBQWNhLE1BQWQsQ0FBc0I7QUFBQSxhQUFLQyxFQUFFQyxJQUFGLEtBQVcsU0FBaEI7QUFBQSxLQUF0QixDQUFQO0FBQ0gsRzs7QUFFRDs7Ozs7Ozs7Ozs7O3dCQVFjO0FBQ1YsYUFBTyxLQUFLZCxHQUFaO0FBQ0g7Ozs7OztrQkFJVUwsTTs7QUFFZiIsImZpbGUiOiJyZXN1bHQuanMiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgV2FybmluZyBmcm9tICcuL3dhcm5pbmcnO1xuXG4vKipcbiAqIFByb3ZpZGVzIHRoZSByZXN1bHQgb2YgdGhlIFBvc3RDU1MgdHJhbnNmb3JtYXRpb25zLlxuICpcbiAqIEEgUmVzdWx0IGluc3RhbmNlIGlzIHJldHVybmVkIGJ5IHtAbGluayBMYXp5UmVzdWx0I3RoZW59XG4gKiBvciB7QGxpbmsgUm9vdCN0b1Jlc3VsdH0gbWV0aG9kcy5cbiAqXG4gKiBAZXhhbXBsZVxuICogcG9zdGNzcyhbY3NzbmV4dF0pLnByb2Nlc3MoY3NzKS50aGVuKGZ1bmN0aW9uIChyZXN1bHQpIHtcbiAqICAgIGNvbnNvbGUubG9nKHJlc3VsdC5jc3MpO1xuICogfSk7XG4gKlxuICogQGV4YW1wbGVcbiAqIHZhciByZXN1bHQyID0gcG9zdGNzcy5wYXJzZShjc3MpLnRvUmVzdWx0KCk7XG4gKi9cbmNsYXNzIFJlc3VsdCB7XG5cbiAgICAvKipcbiAgICAgKiBAcGFyYW0ge1Byb2Nlc3Nvcn0gcHJvY2Vzc29yIC0gcHJvY2Vzc29yIHVzZWQgZm9yIHRoaXMgdHJhbnNmb3JtYXRpb24uXG4gICAgICogQHBhcmFtIHtSb290fSAgICAgIHJvb3QgICAgICAtIFJvb3Qgbm9kZSBhZnRlciBhbGwgdHJhbnNmb3JtYXRpb25zLlxuICAgICAqIEBwYXJhbSB7cHJvY2Vzc09wdGlvbnN9IG9wdHMgLSBvcHRpb25zIGZyb20gdGhlIHtAbGluayBQcm9jZXNzb3IjcHJvY2Vzc31cbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3Ige0BsaW5rIFJvb3QjdG9SZXN1bHR9XG4gICAgICovXG4gICAgY29uc3RydWN0b3IocHJvY2Vzc29yLCByb290LCBvcHRzKSB7XG4gICAgICAgIC8qKlxuICAgICAgICAgKiBAbWVtYmVyIHtQcm9jZXNzb3J9IC0gVGhlIFByb2Nlc3NvciBpbnN0YW5jZSB1c2VkXG4gICAgICAgICAqICAgICAgICAgICAgICAgICAgICAgICBmb3IgdGhpcyB0cmFuc2Zvcm1hdGlvbi5cbiAgICAgICAgICpcbiAgICAgICAgICogQGV4YW1wbGVcbiAgICAgICAgICogZm9yICggbGV0IHBsdWdpbiBvZiByZXN1bHQucHJvY2Vzc29yLnBsdWdpbnMpIHtcbiAgICAgICAgICogICBpZiAoIHBsdWdpbi5wb3N0Y3NzUGx1Z2luID09PSAncG9zdGNzcy1iYWQnICkge1xuICAgICAgICAgKiAgICAgdGhyb3cgJ3Bvc3Rjc3MtZ29vZCBpcyBpbmNvbXBhdGlibGUgd2l0aCBwb3N0Y3NzLWJhZCc7XG4gICAgICAgICAqICAgfVxuICAgICAgICAgKiB9KTtcbiAgICAgICAgICovXG4gICAgICAgIHRoaXMucHJvY2Vzc29yID0gcHJvY2Vzc29yO1xuICAgICAgICAvKipcbiAgICAgICAgICogQG1lbWJlciB7TWVzc2FnZVtdfSAtIENvbnRhaW5zIG1lc3NhZ2VzIGZyb20gcGx1Z2luc1xuICAgICAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgKGUuZy4sIHdhcm5pbmdzIG9yIGN1c3RvbSBtZXNzYWdlcykuXG4gICAgICAgICAqICAgICAgICAgICAgICAgICAgICAgICBFYWNoIG1lc3NhZ2Ugc2hvdWxkIGhhdmUgdHlwZVxuICAgICAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgYW5kIHBsdWdpbiBwcm9wZXJ0aWVzLlxuICAgICAgICAgKlxuICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgKiBwb3N0Y3NzLnBsdWdpbigncG9zdGNzcy1taW4tYnJvd3NlcicsICgpID0+IHtcbiAgICAgICAgICogICByZXR1cm4gKHJvb3QsIHJlc3VsdCkgPT4ge1xuICAgICAgICAgKiAgICAgdmFyIGJyb3dzZXJzID0gZGV0ZWN0TWluQnJvd3NlcnNCeUNhbklVc2Uocm9vdCk7XG4gICAgICAgICAqICAgICByZXN1bHQubWVzc2FnZXMucHVzaCh7XG4gICAgICAgICAqICAgICAgIHR5cGU6ICAgICdtaW4tYnJvd3NlcicsXG4gICAgICAgICAqICAgICAgIHBsdWdpbjogICdwb3N0Y3NzLW1pbi1icm93c2VyJyxcbiAgICAgICAgICogICAgICAgYnJvd3NlcnM6IGJyb3dzZXJzXG4gICAgICAgICAqICAgICB9KTtcbiAgICAgICAgICogICB9O1xuICAgICAgICAgKiB9KTtcbiAgICAgICAgICovXG4gICAgICAgIHRoaXMubWVzc2FnZXMgPSBbXTtcbiAgICAgICAgLyoqXG4gICAgICAgICAqIEBtZW1iZXIge1Jvb3R9IC0gUm9vdCBub2RlIGFmdGVyIGFsbCB0cmFuc2Zvcm1hdGlvbnMuXG4gICAgICAgICAqXG4gICAgICAgICAqIEBleGFtcGxlXG4gICAgICAgICAqIHJvb3QudG9SZXN1bHQoKS5yb290ID09IHJvb3Q7XG4gICAgICAgICAqL1xuICAgICAgICB0aGlzLnJvb3QgPSByb290O1xuICAgICAgICAvKipcbiAgICAgICAgICogQG1lbWJlciB7cHJvY2Vzc09wdGlvbnN9IC0gT3B0aW9ucyBmcm9tIHRoZSB7QGxpbmsgUHJvY2Vzc29yI3Byb2Nlc3N9XG4gICAgICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9yIHtAbGluayBSb290I3RvUmVzdWx0fSBjYWxsXG4gICAgICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoYXQgcHJvZHVjZWQgdGhpcyBSZXN1bHQgaW5zdGFuY2UuXG4gICAgICAgICAqXG4gICAgICAgICAqIEBleGFtcGxlXG4gICAgICAgICAqIHJvb3QudG9SZXN1bHQob3B0cykub3B0cyA9PSBvcHRzO1xuICAgICAgICAgKi9cbiAgICAgICAgdGhpcy5vcHRzID0gb3B0cztcbiAgICAgICAgLyoqXG4gICAgICAgICAqIEBtZW1iZXIge3N0cmluZ30gLSBBIENTUyBzdHJpbmcgcmVwcmVzZW50aW5nIG9mIHtAbGluayBSZXN1bHQjcm9vdH0uXG4gICAgICAgICAqXG4gICAgICAgICAqIEBleGFtcGxlXG4gICAgICAgICAqIHBvc3Rjc3MucGFyc2UoJ2F7fScpLnRvUmVzdWx0KCkuY3NzIC8vPT4gXCJhe31cIlxuICAgICAgICAgKi9cbiAgICAgICAgdGhpcy5jc3MgPSB1bmRlZmluZWQ7XG4gICAgICAgIC8qKlxuICAgICAgICAgKiBAbWVtYmVyIHtTb3VyY2VNYXBHZW5lcmF0b3J9IC0gQW4gaW5zdGFuY2Ugb2YgYFNvdXJjZU1hcEdlbmVyYXRvcmBcbiAgICAgICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzIGZyb20gdGhlIGBzb3VyY2UtbWFwYCBsaWJyYXJ5LFxuICAgICAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVwcmVzZW50aW5nIGNoYW5nZXNcbiAgICAgICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRvIHRoZSB7QGxpbmsgUmVzdWx0I3Jvb3R9IGluc3RhbmNlLlxuICAgICAgICAgKlxuICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgKiByZXN1bHQubWFwLnRvSlNPTigpIC8vPT4geyB2ZXJzaW9uOiAzLCBmaWxlOiAnYS5jc3MnLCDigKYgfVxuICAgICAgICAgKlxuICAgICAgICAgKiBAZXhhbXBsZVxuICAgICAgICAgKiBpZiAoIHJlc3VsdC5tYXAgKSB7XG4gICAgICAgICAqICAgZnMud3JpdGVGaWxlU3luYyhyZXN1bHQub3B0cy50byArICcubWFwJywgcmVzdWx0Lm1hcC50b1N0cmluZygpKTtcbiAgICAgICAgICogfVxuICAgICAgICAgKi9cbiAgICAgICAgdGhpcy5tYXAgPSB1bmRlZmluZWQ7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUmV0dXJucyBmb3IgQHtsaW5rIFJlc3VsdCNjc3N9IGNvbnRlbnQuXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIHJlc3VsdCArICcnID09PSByZXN1bHQuY3NzXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtzdHJpbmd9IHN0cmluZyByZXByZXNlbnRpbmcgb2Yge0BsaW5rIFJlc3VsdCNyb290fVxuICAgICAqL1xuICAgIHRvU3RyaW5nKCkge1xuICAgICAgICByZXR1cm4gdGhpcy5jc3M7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogQ3JlYXRlcyBhbiBpbnN0YW5jZSBvZiB7QGxpbmsgV2FybmluZ30gYW5kIGFkZHMgaXRcbiAgICAgKiB0byB7QGxpbmsgUmVzdWx0I21lc3NhZ2VzfS5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7c3RyaW5nfSB0ZXh0ICAgICAgICAtIHdhcm5pbmcgbWVzc2FnZVxuICAgICAqIEBwYXJhbSB7T2JqZWN0fSBbb3B0c10gICAgICAtIHdhcm5pbmcgb3B0aW9uc1xuICAgICAqIEBwYXJhbSB7Tm9kZX0gICBvcHRzLm5vZGUgICAtIENTUyBub2RlIHRoYXQgY2F1c2VkIHRoZSB3YXJuaW5nXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IG9wdHMud29yZCAgIC0gd29yZCBpbiBDU1Mgc291cmNlIHRoYXQgY2F1c2VkIHRoZSB3YXJuaW5nXG4gICAgICogQHBhcmFtIHtudW1iZXJ9IG9wdHMuaW5kZXggIC0gaW5kZXggaW4gQ1NTIG5vZGUgc3RyaW5nIHRoYXQgY2F1c2VkXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhlIHdhcm5pbmdcbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gb3B0cy5wbHVnaW4gLSBuYW1lIG9mIHRoZSBwbHVnaW4gdGhhdCBjcmVhdGVkXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcyB3YXJuaW5nLiB7QGxpbmsgUmVzdWx0I3dhcm59IGZpbGxzXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpcyBwcm9wZXJ0eSBhdXRvbWF0aWNhbGx5LlxuICAgICAqXG4gICAgICogQHJldHVybiB7V2FybmluZ30gY3JlYXRlZCB3YXJuaW5nXG4gICAgICovXG4gICAgd2Fybih0ZXh0LCBvcHRzID0geyB9KSB7XG4gICAgICAgIGlmICggIW9wdHMucGx1Z2luICkge1xuICAgICAgICAgICAgaWYgKCB0aGlzLmxhc3RQbHVnaW4gJiYgdGhpcy5sYXN0UGx1Z2luLnBvc3Rjc3NQbHVnaW4gKSB7XG4gICAgICAgICAgICAgICAgb3B0cy5wbHVnaW4gPSB0aGlzLmxhc3RQbHVnaW4ucG9zdGNzc1BsdWdpbjtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuXG4gICAgICAgIGxldCB3YXJuaW5nID0gbmV3IFdhcm5pbmcodGV4dCwgb3B0cyk7XG4gICAgICAgIHRoaXMubWVzc2FnZXMucHVzaCh3YXJuaW5nKTtcblxuICAgICAgICByZXR1cm4gd2FybmluZztcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIHdhcm5pbmdzIGZyb20gcGx1Z2lucy4gRmlsdGVycyB7QGxpbmsgV2FybmluZ30gaW5zdGFuY2VzXG4gICAgICogZnJvbSB7QGxpbmsgUmVzdWx0I21lc3NhZ2VzfS5cbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcmVzdWx0Lndhcm5pbmdzKCkuZm9yRWFjaCh3YXJuID0+IHtcbiAgICAgKiAgIGNvbnNvbGUud2Fybih3YXJuLnRvU3RyaW5nKCkpO1xuICAgICAqIH0pO1xuICAgICAqXG4gICAgICogQHJldHVybiB7V2FybmluZ1tdfSB3YXJuaW5ncyBmcm9tIHBsdWdpbnNcbiAgICAgKi9cbiAgICB3YXJuaW5ncygpIHtcbiAgICAgICAgcmV0dXJuIHRoaXMubWVzc2FnZXMuZmlsdGVyKCBpID0+IGkudHlwZSA9PT0gJ3dhcm5pbmcnICk7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogQW4gYWxpYXMgZm9yIHRoZSB7QGxpbmsgUmVzdWx0I2Nzc30gcHJvcGVydHkuXG4gICAgICogVXNlIGl0IHdpdGggc3ludGF4ZXMgdGhhdCBnZW5lcmF0ZSBub24tQ1NTIG91dHB1dC5cbiAgICAgKiBAdHlwZSB7c3RyaW5nfVxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiByZXN1bHQuY3NzID09PSByZXN1bHQuY29udGVudDtcbiAgICAgKi9cbiAgICBnZXQgY29udGVudCgpIHtcbiAgICAgICAgcmV0dXJuIHRoaXMuY3NzO1xuICAgIH1cblxufVxuXG5leHBvcnQgZGVmYXVsdCBSZXN1bHQ7XG5cbi8qKlxuICogQHR5cGVkZWYgIHtvYmplY3R9IE1lc3NhZ2VcbiAqIEBwcm9wZXJ0eSB7c3RyaW5nfSB0eXBlICAgLSBtZXNzYWdlIHR5cGVcbiAqIEBwcm9wZXJ0eSB7c3RyaW5nfSBwbHVnaW4gLSBzb3VyY2UgUG9zdENTUyBwbHVnaW4gbmFtZVxuICovXG4iXX0=
