'use strict';

exports.__esModule = true;

var _declaration = require('./declaration');

var _declaration2 = _interopRequireDefault(_declaration);

var _processor = require('./processor');

var _processor2 = _interopRequireDefault(_processor);

var _stringify = require('./stringify');

var _stringify2 = _interopRequireDefault(_stringify);

var _comment = require('./comment');

var _comment2 = _interopRequireDefault(_comment);

var _atRule = require('./at-rule');

var _atRule2 = _interopRequireDefault(_atRule);

var _vendor = require('./vendor');

var _vendor2 = _interopRequireDefault(_vendor);

var _parse = require('./parse');

var _parse2 = _interopRequireDefault(_parse);

var _list = require('./list');

var _list2 = _interopRequireDefault(_list);

var _rule = require('./rule');

var _rule2 = _interopRequireDefault(_rule);

var _root = require('./root');

var _root2 = _interopRequireDefault(_root);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Create a new {@link Processor} instance that will apply `plugins`
 * as CSS processors.
 *
 * @param {Array.<Plugin|pluginFunction>|Processor} plugins - PostCSS
 *        plugins. See {@link Processor#use} for plugin format.
 *
 * @return {Processor} Processor to process multiple CSS
 *
 * @example
 * import postcss from 'postcss';
 *
 * postcss(plugins).process(css, { from, to }).then(result => {
 *   console.log(result.css);
 * });
 *
 * @namespace postcss
 */
function postcss() {
  for (var _len = arguments.length, plugins = Array(_len), _key = 0; _key < _len; _key++) {
    plugins[_key] = arguments[_key];
  }

  if (plugins.length === 1 && Array.isArray(plugins[0])) {
    plugins = plugins[0];
  }
  return new _processor2.default(plugins);
}

/**
 * Creates a PostCSS plugin with a standard API.
 *
 * The newly-wrapped function will provide both the name and PostCSS
 * version of the plugin.
 *
 * ```js
 *  const processor = postcss([replace]);
 *  processor.plugins[0].postcssPlugin  //=> 'postcss-replace'
 *  processor.plugins[0].postcssVersion //=> '5.1.0'
 * ```
 *
 * The plugin function receives 2 arguments: {@link Root}
 * and {@link Result} instance. The function should mutate the provided
 * `Root` node. Alternatively, you can create a new `Root` node
 * and override the `result.root` property.
 *
 * ```js
 * const cleaner = postcss.plugin('postcss-cleaner', () => {
 *   return (root, result) => {
 *     result.root = postcss.root();
 *   };
 * });
 * ```
 *
 * As a convenience, plugins also expose a `process` method so that you can use
 * them as standalone tools.
 *
 * ```js
 * cleaner.process(css, options);
 * // This is equivalent to:
 * postcss([ cleaner(options) ]).process(css);
 * ```
 *
 * Asynchronous plugins should return a `Promise` instance.
 *
 * ```js
 * postcss.plugin('postcss-import', () => {
 *   return (root, result) => {
 *     return new Promise( (resolve, reject) => {
 *       fs.readFile('base.css', (base) => {
 *         root.prepend(base);
 *         resolve();
 *       });
 *     });
 *   };
 * });
 * ```
 *
 * Add warnings using the {@link Node#warn} method.
 * Send data to other plugins using the {@link Result#messages} array.
 *
 * ```js
 * postcss.plugin('postcss-caniuse-test', () => {
 *   return (root, result) => {
 *     css.walkDecls(decl => {
 *       if ( !caniuse.support(decl.prop) ) {
 *         decl.warn(result, 'Some browsers do not support ' + decl.prop);
 *       }
 *     });
 *   };
 * });
 * ```
 *
 * @param {string} name          - PostCSS plugin name. Same as in `name`
 *                                 property in `package.json`. It will be saved
 *                                 in `plugin.postcssPlugin` property.
 * @param {function} initializer - will receive plugin options
 *                                 and should return {@link pluginFunction}
 *
 * @return {Plugin} PostCSS plugin
 */
postcss.plugin = function plugin(name, initializer) {
  var creator = function creator() {
    var transformer = initializer.apply(undefined, arguments);
    transformer.postcssPlugin = name;
    transformer.postcssVersion = new _processor2.default().version;
    return transformer;
  };

  var cache = void 0;
  Object.defineProperty(creator, 'postcss', {
    get: function get() {
      if (!cache) cache = creator();
      return cache;
    }
  });

  creator.process = function (root, opts) {
    return postcss([creator(opts)]).process(root, opts);
  };

  return creator;
};

/**
 * Default function to convert a node tree into a CSS string.
 *
 * @param {Node} node       - start node for stringifing. Usually {@link Root}.
 * @param {builder} builder - function to concatenate CSS from node’s parts
 *                            or generate string and source map
 *
 * @return {void}
 *
 * @function
 */
postcss.stringify = _stringify2.default;

/**
 * Parses source css and returns a new {@link Root} node,
 * which contains the source CSS nodes.
 *
 * @param {string|toString} css   - string with input CSS or any object
 *                                  with toString() method, like a Buffer
 * @param {processOptions} [opts] - options with only `from` and `map` keys
 *
 * @return {Root} PostCSS AST
 *
 * @example
 * // Simple CSS concatenation with source map support
 * const root1 = postcss.parse(css1, { from: file1 });
 * const root2 = postcss.parse(css2, { from: file2 });
 * root1.append(root2).toResult().css;
 *
 * @function
 */
postcss.parse = _parse2.default;

/**
 * @member {vendor} - Contains the {@link vendor} module.
 *
 * @example
 * postcss.vendor.unprefixed('-moz-tab') //=> ['tab']
 */
postcss.vendor = _vendor2.default;

/**
 * @member {list} - Contains the {@link list} module.
 *
 * @example
 * postcss.list.space('5px calc(10% + 5px)') //=> ['5px', 'calc(10% + 5px)']
 */
postcss.list = _list2.default;

/**
 * Creates a new {@link Comment} node.
 *
 * @param {object} [defaults] - properties for the new node.
 *
 * @return {Comment} new Comment node
 *
 * @example
 * postcss.comment({ text: 'test' })
 */
postcss.comment = function (defaults) {
  return new _comment2.default(defaults);
};

/**
 * Creates a new {@link AtRule} node.
 *
 * @param {object} [defaults] - properties for the new node.
 *
 * @return {AtRule} new AtRule node
 *
 * @example
 * postcss.atRule({ name: 'charset' }).toString() //=> "@charset"
 */
postcss.atRule = function (defaults) {
  return new _atRule2.default(defaults);
};

/**
 * Creates a new {@link Declaration} node.
 *
 * @param {object} [defaults] - properties for the new node.
 *
 * @return {Declaration} new Declaration node
 *
 * @example
 * postcss.decl({ prop: 'color', value: 'red' }).toString() //=> "color: red"
 */
postcss.decl = function (defaults) {
  return new _declaration2.default(defaults);
};

/**
 * Creates a new {@link Rule} node.
 *
 * @param {object} [defaults] - properties for the new node.
 *
 * @return {AtRule} new Rule node
 *
 * @example
 * postcss.rule({ selector: 'a' }).toString() //=> "a {\n}"
 */
postcss.rule = function (defaults) {
  return new _rule2.default(defaults);
};

/**
 * Creates a new {@link Root} node.
 *
 * @param {object} [defaults] - properties for the new node.
 *
 * @return {Root} new Root node
 *
 * @example
 * postcss.root({ after: '\n' }).toString() //=> "\n"
 */
postcss.root = function (defaults) {
  return new _root2.default(defaults);
};

exports.default = postcss;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvcG9zdGNzcy5lczYiXSwibmFtZXMiOlsicG9zdGNzcyIsInBsdWdpbnMiLCJsZW5ndGgiLCJBcnJheSIsImlzQXJyYXkiLCJwbHVnaW4iLCJuYW1lIiwiaW5pdGlhbGl6ZXIiLCJjcmVhdG9yIiwidHJhbnNmb3JtZXIiLCJwb3N0Y3NzUGx1Z2luIiwicG9zdGNzc1ZlcnNpb24iLCJ2ZXJzaW9uIiwiY2FjaGUiLCJPYmplY3QiLCJkZWZpbmVQcm9wZXJ0eSIsImdldCIsInByb2Nlc3MiLCJyb290Iiwib3B0cyIsInN0cmluZ2lmeSIsInBhcnNlIiwidmVuZG9yIiwibGlzdCIsImNvbW1lbnQiLCJkZWZhdWx0cyIsImF0UnVsZSIsImRlY2wiLCJydWxlIl0sIm1hcHBpbmdzIjoiOzs7O0FBQUE7Ozs7QUFDQTs7OztBQUNBOzs7O0FBQ0E7Ozs7QUFDQTs7OztBQUNBOzs7O0FBQ0E7Ozs7QUFDQTs7OztBQUNBOzs7O0FBQ0E7Ozs7OztBQUVBOzs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFrQkEsU0FBU0EsT0FBVCxHQUE2QjtBQUFBLG9DQUFUQyxPQUFTO0FBQVRBLFdBQVM7QUFBQTs7QUFDekIsTUFBS0EsUUFBUUMsTUFBUixLQUFtQixDQUFuQixJQUF3QkMsTUFBTUMsT0FBTixDQUFjSCxRQUFRLENBQVIsQ0FBZCxDQUE3QixFQUF5RDtBQUNyREEsY0FBVUEsUUFBUSxDQUFSLENBQVY7QUFDSDtBQUNELFNBQU8sd0JBQWNBLE9BQWQsQ0FBUDtBQUNIOztBQUVEOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUF3RUFELFFBQVFLLE1BQVIsR0FBaUIsU0FBU0EsTUFBVCxDQUFnQkMsSUFBaEIsRUFBc0JDLFdBQXRCLEVBQW1DO0FBQ2hELE1BQUlDLFVBQVUsU0FBVkEsT0FBVSxHQUFtQjtBQUM3QixRQUFJQyxjQUFjRix1Q0FBbEI7QUFDQUUsZ0JBQVlDLGFBQVosR0FBNkJKLElBQTdCO0FBQ0FHLGdCQUFZRSxjQUFaLEdBQThCLHlCQUFELENBQWtCQyxPQUEvQztBQUNBLFdBQU9ILFdBQVA7QUFDSCxHQUxEOztBQU9BLE1BQUlJLGNBQUo7QUFDQUMsU0FBT0MsY0FBUCxDQUFzQlAsT0FBdEIsRUFBK0IsU0FBL0IsRUFBMEM7QUFDdENRLE9BRHNDLGlCQUNoQztBQUNGLFVBQUssQ0FBQ0gsS0FBTixFQUFjQSxRQUFRTCxTQUFSO0FBQ2QsYUFBT0ssS0FBUDtBQUNIO0FBSnFDLEdBQTFDOztBQU9BTCxVQUFRUyxPQUFSLEdBQWtCLFVBQVVDLElBQVYsRUFBZ0JDLElBQWhCLEVBQXNCO0FBQ3BDLFdBQU9uQixRQUFRLENBQUVRLFFBQVFXLElBQVIsQ0FBRixDQUFSLEVBQTJCRixPQUEzQixDQUFtQ0MsSUFBbkMsRUFBeUNDLElBQXpDLENBQVA7QUFDSCxHQUZEOztBQUlBLFNBQU9YLE9BQVA7QUFDSCxDQXJCRDs7QUF1QkE7Ozs7Ozs7Ozs7O0FBV0FSLFFBQVFvQixTQUFSOztBQUVBOzs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFrQkFwQixRQUFRcUIsS0FBUjs7QUFFQTs7Ozs7O0FBTUFyQixRQUFRc0IsTUFBUjs7QUFFQTs7Ozs7O0FBTUF0QixRQUFRdUIsSUFBUjs7QUFFQTs7Ozs7Ozs7OztBQVVBdkIsUUFBUXdCLE9BQVIsR0FBa0I7QUFBQSxTQUFZLHNCQUFZQyxRQUFaLENBQVo7QUFBQSxDQUFsQjs7QUFFQTs7Ozs7Ozs7OztBQVVBekIsUUFBUTBCLE1BQVIsR0FBaUI7QUFBQSxTQUFZLHFCQUFXRCxRQUFYLENBQVo7QUFBQSxDQUFqQjs7QUFFQTs7Ozs7Ozs7OztBQVVBekIsUUFBUTJCLElBQVIsR0FBZTtBQUFBLFNBQVksMEJBQWdCRixRQUFoQixDQUFaO0FBQUEsQ0FBZjs7QUFFQTs7Ozs7Ozs7OztBQVVBekIsUUFBUTRCLElBQVIsR0FBZTtBQUFBLFNBQVksbUJBQVNILFFBQVQsQ0FBWjtBQUFBLENBQWY7O0FBRUE7Ozs7Ozs7Ozs7QUFVQXpCLFFBQVFrQixJQUFSLEdBQWU7QUFBQSxTQUFZLG1CQUFTTyxRQUFULENBQVo7QUFBQSxDQUFmOztrQkFFZXpCLE8iLCJmaWxlIjoicG9zdGNzcy5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBEZWNsYXJhdGlvbiBmcm9tICcuL2RlY2xhcmF0aW9uJztcbmltcG9ydCBQcm9jZXNzb3IgICBmcm9tICcuL3Byb2Nlc3Nvcic7XG5pbXBvcnQgc3RyaW5naWZ5ICAgZnJvbSAnLi9zdHJpbmdpZnknO1xuaW1wb3J0IENvbW1lbnQgICAgIGZyb20gJy4vY29tbWVudCc7XG5pbXBvcnQgQXRSdWxlICAgICAgZnJvbSAnLi9hdC1ydWxlJztcbmltcG9ydCB2ZW5kb3IgICAgICBmcm9tICcuL3ZlbmRvcic7XG5pbXBvcnQgcGFyc2UgICAgICAgZnJvbSAnLi9wYXJzZSc7XG5pbXBvcnQgbGlzdCAgICAgICAgZnJvbSAnLi9saXN0JztcbmltcG9ydCBSdWxlICAgICAgICBmcm9tICcuL3J1bGUnO1xuaW1wb3J0IFJvb3QgICAgICAgIGZyb20gJy4vcm9vdCc7XG5cbi8qKlxuICogQ3JlYXRlIGEgbmV3IHtAbGluayBQcm9jZXNzb3J9IGluc3RhbmNlIHRoYXQgd2lsbCBhcHBseSBgcGx1Z2luc2BcbiAqIGFzIENTUyBwcm9jZXNzb3JzLlxuICpcbiAqIEBwYXJhbSB7QXJyYXkuPFBsdWdpbnxwbHVnaW5GdW5jdGlvbj58UHJvY2Vzc29yfSBwbHVnaW5zIC0gUG9zdENTU1xuICogICAgICAgIHBsdWdpbnMuIFNlZSB7QGxpbmsgUHJvY2Vzc29yI3VzZX0gZm9yIHBsdWdpbiBmb3JtYXQuXG4gKlxuICogQHJldHVybiB7UHJvY2Vzc29yfSBQcm9jZXNzb3IgdG8gcHJvY2VzcyBtdWx0aXBsZSBDU1NcbiAqXG4gKiBAZXhhbXBsZVxuICogaW1wb3J0IHBvc3Rjc3MgZnJvbSAncG9zdGNzcyc7XG4gKlxuICogcG9zdGNzcyhwbHVnaW5zKS5wcm9jZXNzKGNzcywgeyBmcm9tLCB0byB9KS50aGVuKHJlc3VsdCA9PiB7XG4gKiAgIGNvbnNvbGUubG9nKHJlc3VsdC5jc3MpO1xuICogfSk7XG4gKlxuICogQG5hbWVzcGFjZSBwb3N0Y3NzXG4gKi9cbmZ1bmN0aW9uIHBvc3Rjc3MoLi4ucGx1Z2lucykge1xuICAgIGlmICggcGx1Z2lucy5sZW5ndGggPT09IDEgJiYgQXJyYXkuaXNBcnJheShwbHVnaW5zWzBdKSApIHtcbiAgICAgICAgcGx1Z2lucyA9IHBsdWdpbnNbMF07XG4gICAgfVxuICAgIHJldHVybiBuZXcgUHJvY2Vzc29yKHBsdWdpbnMpO1xufVxuXG4vKipcbiAqIENyZWF0ZXMgYSBQb3N0Q1NTIHBsdWdpbiB3aXRoIGEgc3RhbmRhcmQgQVBJLlxuICpcbiAqIFRoZSBuZXdseS13cmFwcGVkIGZ1bmN0aW9uIHdpbGwgcHJvdmlkZSBib3RoIHRoZSBuYW1lIGFuZCBQb3N0Q1NTXG4gKiB2ZXJzaW9uIG9mIHRoZSBwbHVnaW4uXG4gKlxuICogYGBganNcbiAqICBjb25zdCBwcm9jZXNzb3IgPSBwb3N0Y3NzKFtyZXBsYWNlXSk7XG4gKiAgcHJvY2Vzc29yLnBsdWdpbnNbMF0ucG9zdGNzc1BsdWdpbiAgLy89PiAncG9zdGNzcy1yZXBsYWNlJ1xuICogIHByb2Nlc3Nvci5wbHVnaW5zWzBdLnBvc3Rjc3NWZXJzaW9uIC8vPT4gJzUuMS4wJ1xuICogYGBgXG4gKlxuICogVGhlIHBsdWdpbiBmdW5jdGlvbiByZWNlaXZlcyAyIGFyZ3VtZW50czoge0BsaW5rIFJvb3R9XG4gKiBhbmQge0BsaW5rIFJlc3VsdH0gaW5zdGFuY2UuIFRoZSBmdW5jdGlvbiBzaG91bGQgbXV0YXRlIHRoZSBwcm92aWRlZFxuICogYFJvb3RgIG5vZGUuIEFsdGVybmF0aXZlbHksIHlvdSBjYW4gY3JlYXRlIGEgbmV3IGBSb290YCBub2RlXG4gKiBhbmQgb3ZlcnJpZGUgdGhlIGByZXN1bHQucm9vdGAgcHJvcGVydHkuXG4gKlxuICogYGBganNcbiAqIGNvbnN0IGNsZWFuZXIgPSBwb3N0Y3NzLnBsdWdpbigncG9zdGNzcy1jbGVhbmVyJywgKCkgPT4ge1xuICogICByZXR1cm4gKHJvb3QsIHJlc3VsdCkgPT4ge1xuICogICAgIHJlc3VsdC5yb290ID0gcG9zdGNzcy5yb290KCk7XG4gKiAgIH07XG4gKiB9KTtcbiAqIGBgYFxuICpcbiAqIEFzIGEgY29udmVuaWVuY2UsIHBsdWdpbnMgYWxzbyBleHBvc2UgYSBgcHJvY2Vzc2AgbWV0aG9kIHNvIHRoYXQgeW91IGNhbiB1c2VcbiAqIHRoZW0gYXMgc3RhbmRhbG9uZSB0b29scy5cbiAqXG4gKiBgYGBqc1xuICogY2xlYW5lci5wcm9jZXNzKGNzcywgb3B0aW9ucyk7XG4gKiAvLyBUaGlzIGlzIGVxdWl2YWxlbnQgdG86XG4gKiBwb3N0Y3NzKFsgY2xlYW5lcihvcHRpb25zKSBdKS5wcm9jZXNzKGNzcyk7XG4gKiBgYGBcbiAqXG4gKiBBc3luY2hyb25vdXMgcGx1Z2lucyBzaG91bGQgcmV0dXJuIGEgYFByb21pc2VgIGluc3RhbmNlLlxuICpcbiAqIGBgYGpzXG4gKiBwb3N0Y3NzLnBsdWdpbigncG9zdGNzcy1pbXBvcnQnLCAoKSA9PiB7XG4gKiAgIHJldHVybiAocm9vdCwgcmVzdWx0KSA9PiB7XG4gKiAgICAgcmV0dXJuIG5ldyBQcm9taXNlKCAocmVzb2x2ZSwgcmVqZWN0KSA9PiB7XG4gKiAgICAgICBmcy5yZWFkRmlsZSgnYmFzZS5jc3MnLCAoYmFzZSkgPT4ge1xuICogICAgICAgICByb290LnByZXBlbmQoYmFzZSk7XG4gKiAgICAgICAgIHJlc29sdmUoKTtcbiAqICAgICAgIH0pO1xuICogICAgIH0pO1xuICogICB9O1xuICogfSk7XG4gKiBgYGBcbiAqXG4gKiBBZGQgd2FybmluZ3MgdXNpbmcgdGhlIHtAbGluayBOb2RlI3dhcm59IG1ldGhvZC5cbiAqIFNlbmQgZGF0YSB0byBvdGhlciBwbHVnaW5zIHVzaW5nIHRoZSB7QGxpbmsgUmVzdWx0I21lc3NhZ2VzfSBhcnJheS5cbiAqXG4gKiBgYGBqc1xuICogcG9zdGNzcy5wbHVnaW4oJ3Bvc3Rjc3MtY2FuaXVzZS10ZXN0JywgKCkgPT4ge1xuICogICByZXR1cm4gKHJvb3QsIHJlc3VsdCkgPT4ge1xuICogICAgIGNzcy53YWxrRGVjbHMoZGVjbCA9PiB7XG4gKiAgICAgICBpZiAoICFjYW5pdXNlLnN1cHBvcnQoZGVjbC5wcm9wKSApIHtcbiAqICAgICAgICAgZGVjbC53YXJuKHJlc3VsdCwgJ1NvbWUgYnJvd3NlcnMgZG8gbm90IHN1cHBvcnQgJyArIGRlY2wucHJvcCk7XG4gKiAgICAgICB9XG4gKiAgICAgfSk7XG4gKiAgIH07XG4gKiB9KTtcbiAqIGBgYFxuICpcbiAqIEBwYXJhbSB7c3RyaW5nfSBuYW1lICAgICAgICAgIC0gUG9zdENTUyBwbHVnaW4gbmFtZS4gU2FtZSBhcyBpbiBgbmFtZWBcbiAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJvcGVydHkgaW4gYHBhY2thZ2UuanNvbmAuIEl0IHdpbGwgYmUgc2F2ZWRcbiAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW4gYHBsdWdpbi5wb3N0Y3NzUGx1Z2luYCBwcm9wZXJ0eS5cbiAqIEBwYXJhbSB7ZnVuY3Rpb259IGluaXRpYWxpemVyIC0gd2lsbCByZWNlaXZlIHBsdWdpbiBvcHRpb25zXG4gKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuZCBzaG91bGQgcmV0dXJuIHtAbGluayBwbHVnaW5GdW5jdGlvbn1cbiAqXG4gKiBAcmV0dXJuIHtQbHVnaW59IFBvc3RDU1MgcGx1Z2luXG4gKi9cbnBvc3Rjc3MucGx1Z2luID0gZnVuY3Rpb24gcGx1Z2luKG5hbWUsIGluaXRpYWxpemVyKSB7XG4gICAgbGV0IGNyZWF0b3IgPSBmdW5jdGlvbiAoLi4uYXJncykge1xuICAgICAgICBsZXQgdHJhbnNmb3JtZXIgPSBpbml0aWFsaXplciguLi5hcmdzKTtcbiAgICAgICAgdHJhbnNmb3JtZXIucG9zdGNzc1BsdWdpbiAgPSBuYW1lO1xuICAgICAgICB0cmFuc2Zvcm1lci5wb3N0Y3NzVmVyc2lvbiA9IChuZXcgUHJvY2Vzc29yKCkpLnZlcnNpb247XG4gICAgICAgIHJldHVybiB0cmFuc2Zvcm1lcjtcbiAgICB9O1xuXG4gICAgbGV0IGNhY2hlO1xuICAgIE9iamVjdC5kZWZpbmVQcm9wZXJ0eShjcmVhdG9yLCAncG9zdGNzcycsIHtcbiAgICAgICAgZ2V0KCkge1xuICAgICAgICAgICAgaWYgKCAhY2FjaGUgKSBjYWNoZSA9IGNyZWF0b3IoKTtcbiAgICAgICAgICAgIHJldHVybiBjYWNoZTtcbiAgICAgICAgfVxuICAgIH0pO1xuXG4gICAgY3JlYXRvci5wcm9jZXNzID0gZnVuY3Rpb24gKHJvb3QsIG9wdHMpIHtcbiAgICAgICAgcmV0dXJuIHBvc3Rjc3MoWyBjcmVhdG9yKG9wdHMpIF0pLnByb2Nlc3Mocm9vdCwgb3B0cyk7XG4gICAgfTtcblxuICAgIHJldHVybiBjcmVhdG9yO1xufTtcblxuLyoqXG4gKiBEZWZhdWx0IGZ1bmN0aW9uIHRvIGNvbnZlcnQgYSBub2RlIHRyZWUgaW50byBhIENTUyBzdHJpbmcuXG4gKlxuICogQHBhcmFtIHtOb2RlfSBub2RlICAgICAgIC0gc3RhcnQgbm9kZSBmb3Igc3RyaW5naWZpbmcuIFVzdWFsbHkge0BsaW5rIFJvb3R9LlxuICogQHBhcmFtIHtidWlsZGVyfSBidWlsZGVyIC0gZnVuY3Rpb24gdG8gY29uY2F0ZW5hdGUgQ1NTIGZyb20gbm9kZeKAmXMgcGFydHNcbiAqICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9yIGdlbmVyYXRlIHN0cmluZyBhbmQgc291cmNlIG1hcFxuICpcbiAqIEByZXR1cm4ge3ZvaWR9XG4gKlxuICogQGZ1bmN0aW9uXG4gKi9cbnBvc3Rjc3Muc3RyaW5naWZ5ID0gc3RyaW5naWZ5O1xuXG4vKipcbiAqIFBhcnNlcyBzb3VyY2UgY3NzIGFuZCByZXR1cm5zIGEgbmV3IHtAbGluayBSb290fSBub2RlLFxuICogd2hpY2ggY29udGFpbnMgdGhlIHNvdXJjZSBDU1Mgbm9kZXMuXG4gKlxuICogQHBhcmFtIHtzdHJpbmd8dG9TdHJpbmd9IGNzcyAgIC0gc3RyaW5nIHdpdGggaW5wdXQgQ1NTIG9yIGFueSBvYmplY3RcbiAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdpdGggdG9TdHJpbmcoKSBtZXRob2QsIGxpa2UgYSBCdWZmZXJcbiAqIEBwYXJhbSB7cHJvY2Vzc09wdGlvbnN9IFtvcHRzXSAtIG9wdGlvbnMgd2l0aCBvbmx5IGBmcm9tYCBhbmQgYG1hcGAga2V5c1xuICpcbiAqIEByZXR1cm4ge1Jvb3R9IFBvc3RDU1MgQVNUXG4gKlxuICogQGV4YW1wbGVcbiAqIC8vIFNpbXBsZSBDU1MgY29uY2F0ZW5hdGlvbiB3aXRoIHNvdXJjZSBtYXAgc3VwcG9ydFxuICogY29uc3Qgcm9vdDEgPSBwb3N0Y3NzLnBhcnNlKGNzczEsIHsgZnJvbTogZmlsZTEgfSk7XG4gKiBjb25zdCByb290MiA9IHBvc3Rjc3MucGFyc2UoY3NzMiwgeyBmcm9tOiBmaWxlMiB9KTtcbiAqIHJvb3QxLmFwcGVuZChyb290MikudG9SZXN1bHQoKS5jc3M7XG4gKlxuICogQGZ1bmN0aW9uXG4gKi9cbnBvc3Rjc3MucGFyc2UgPSBwYXJzZTtcblxuLyoqXG4gKiBAbWVtYmVyIHt2ZW5kb3J9IC0gQ29udGFpbnMgdGhlIHtAbGluayB2ZW5kb3J9IG1vZHVsZS5cbiAqXG4gKiBAZXhhbXBsZVxuICogcG9zdGNzcy52ZW5kb3IudW5wcmVmaXhlZCgnLW1vei10YWInKSAvLz0+IFsndGFiJ11cbiAqL1xucG9zdGNzcy52ZW5kb3IgPSB2ZW5kb3I7XG5cbi8qKlxuICogQG1lbWJlciB7bGlzdH0gLSBDb250YWlucyB0aGUge0BsaW5rIGxpc3R9IG1vZHVsZS5cbiAqXG4gKiBAZXhhbXBsZVxuICogcG9zdGNzcy5saXN0LnNwYWNlKCc1cHggY2FsYygxMCUgKyA1cHgpJykgLy89PiBbJzVweCcsICdjYWxjKDEwJSArIDVweCknXVxuICovXG5wb3N0Y3NzLmxpc3QgPSBsaXN0O1xuXG4vKipcbiAqIENyZWF0ZXMgYSBuZXcge0BsaW5rIENvbW1lbnR9IG5vZGUuXG4gKlxuICogQHBhcmFtIHtvYmplY3R9IFtkZWZhdWx0c10gLSBwcm9wZXJ0aWVzIGZvciB0aGUgbmV3IG5vZGUuXG4gKlxuICogQHJldHVybiB7Q29tbWVudH0gbmV3IENvbW1lbnQgbm9kZVxuICpcbiAqIEBleGFtcGxlXG4gKiBwb3N0Y3NzLmNvbW1lbnQoeyB0ZXh0OiAndGVzdCcgfSlcbiAqL1xucG9zdGNzcy5jb21tZW50ID0gZGVmYXVsdHMgPT4gbmV3IENvbW1lbnQoZGVmYXVsdHMpO1xuXG4vKipcbiAqIENyZWF0ZXMgYSBuZXcge0BsaW5rIEF0UnVsZX0gbm9kZS5cbiAqXG4gKiBAcGFyYW0ge29iamVjdH0gW2RlZmF1bHRzXSAtIHByb3BlcnRpZXMgZm9yIHRoZSBuZXcgbm9kZS5cbiAqXG4gKiBAcmV0dXJuIHtBdFJ1bGV9IG5ldyBBdFJ1bGUgbm9kZVxuICpcbiAqIEBleGFtcGxlXG4gKiBwb3N0Y3NzLmF0UnVsZSh7IG5hbWU6ICdjaGFyc2V0JyB9KS50b1N0cmluZygpIC8vPT4gXCJAY2hhcnNldFwiXG4gKi9cbnBvc3Rjc3MuYXRSdWxlID0gZGVmYXVsdHMgPT4gbmV3IEF0UnVsZShkZWZhdWx0cyk7XG5cbi8qKlxuICogQ3JlYXRlcyBhIG5ldyB7QGxpbmsgRGVjbGFyYXRpb259IG5vZGUuXG4gKlxuICogQHBhcmFtIHtvYmplY3R9IFtkZWZhdWx0c10gLSBwcm9wZXJ0aWVzIGZvciB0aGUgbmV3IG5vZGUuXG4gKlxuICogQHJldHVybiB7RGVjbGFyYXRpb259IG5ldyBEZWNsYXJhdGlvbiBub2RlXG4gKlxuICogQGV4YW1wbGVcbiAqIHBvc3Rjc3MuZGVjbCh7IHByb3A6ICdjb2xvcicsIHZhbHVlOiAncmVkJyB9KS50b1N0cmluZygpIC8vPT4gXCJjb2xvcjogcmVkXCJcbiAqL1xucG9zdGNzcy5kZWNsID0gZGVmYXVsdHMgPT4gbmV3IERlY2xhcmF0aW9uKGRlZmF1bHRzKTtcblxuLyoqXG4gKiBDcmVhdGVzIGEgbmV3IHtAbGluayBSdWxlfSBub2RlLlxuICpcbiAqIEBwYXJhbSB7b2JqZWN0fSBbZGVmYXVsdHNdIC0gcHJvcGVydGllcyBmb3IgdGhlIG5ldyBub2RlLlxuICpcbiAqIEByZXR1cm4ge0F0UnVsZX0gbmV3IFJ1bGUgbm9kZVxuICpcbiAqIEBleGFtcGxlXG4gKiBwb3N0Y3NzLnJ1bGUoeyBzZWxlY3RvcjogJ2EnIH0pLnRvU3RyaW5nKCkgLy89PiBcImEge1xcbn1cIlxuICovXG5wb3N0Y3NzLnJ1bGUgPSBkZWZhdWx0cyA9PiBuZXcgUnVsZShkZWZhdWx0cyk7XG5cbi8qKlxuICogQ3JlYXRlcyBhIG5ldyB7QGxpbmsgUm9vdH0gbm9kZS5cbiAqXG4gKiBAcGFyYW0ge29iamVjdH0gW2RlZmF1bHRzXSAtIHByb3BlcnRpZXMgZm9yIHRoZSBuZXcgbm9kZS5cbiAqXG4gKiBAcmV0dXJuIHtSb290fSBuZXcgUm9vdCBub2RlXG4gKlxuICogQGV4YW1wbGVcbiAqIHBvc3Rjc3Mucm9vdCh7IGFmdGVyOiAnXFxuJyB9KS50b1N0cmluZygpIC8vPT4gXCJcXG5cIlxuICovXG5wb3N0Y3NzLnJvb3QgPSBkZWZhdWx0cyA9PiBuZXcgUm9vdChkZWZhdWx0cyk7XG5cbmV4cG9ydCBkZWZhdWx0IHBvc3Rjc3M7XG4iXX0=
