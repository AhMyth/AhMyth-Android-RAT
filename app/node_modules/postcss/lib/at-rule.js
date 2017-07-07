'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _container = require('./container');

var _container2 = _interopRequireDefault(_container);

var _warnOnce = require('./warn-once');

var _warnOnce2 = _interopRequireDefault(_warnOnce);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

/**
 * Represents an at-rule.
 *
 * If it’s followed in the CSS by a {} block, this node will have
 * a nodes property representing its children.
 *
 * @extends Container
 *
 * @example
 * const root = postcss.parse('@charset "UTF-8"; @media print {}');
 *
 * const charset = root.first;
 * charset.type  //=> 'atrule'
 * charset.nodes //=> undefined
 *
 * const media = root.last;
 * media.nodes   //=> []
 */
var AtRule = function (_Container) {
    _inherits(AtRule, _Container);

    function AtRule(defaults) {
        _classCallCheck(this, AtRule);

        var _this = _possibleConstructorReturn(this, _Container.call(this, defaults));

        _this.type = 'atrule';
        return _this;
    }

    AtRule.prototype.append = function append() {
        var _Container$prototype$;

        if (!this.nodes) this.nodes = [];

        for (var _len = arguments.length, children = Array(_len), _key = 0; _key < _len; _key++) {
            children[_key] = arguments[_key];
        }

        return (_Container$prototype$ = _Container.prototype.append).call.apply(_Container$prototype$, [this].concat(children));
    };

    AtRule.prototype.prepend = function prepend() {
        var _Container$prototype$2;

        if (!this.nodes) this.nodes = [];

        for (var _len2 = arguments.length, children = Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
            children[_key2] = arguments[_key2];
        }

        return (_Container$prototype$2 = _Container.prototype.prepend).call.apply(_Container$prototype$2, [this].concat(children));
    };

    _createClass(AtRule, [{
        key: 'afterName',
        get: function get() {
            (0, _warnOnce2.default)('AtRule#afterName was deprecated. Use AtRule#raws.afterName');
            return this.raws.afterName;
        },
        set: function set(val) {
            (0, _warnOnce2.default)('AtRule#afterName was deprecated. Use AtRule#raws.afterName');
            this.raws.afterName = val;
        }
    }, {
        key: '_params',
        get: function get() {
            (0, _warnOnce2.default)('AtRule#_params was deprecated. Use AtRule#raws.params');
            return this.raws.params;
        },
        set: function set(val) {
            (0, _warnOnce2.default)('AtRule#_params was deprecated. Use AtRule#raws.params');
            this.raws.params = val;
        }

        /**
         * @memberof AtRule#
         * @member {string} name - the at-rule’s name immediately follows the `@`
         *
         * @example
         * const root  = postcss.parse('@media print {}');
         * media.name //=> 'media'
         * const media = root.first;
         */

        /**
         * @memberof AtRule#
         * @member {string} params - the at-rule’s parameters, the values
         *                           that follow the at-rule’s name but precede
         *                           any {} block
         *
         * @example
         * const root  = postcss.parse('@media print, screen {}');
         * const media = root.first;
         * media.params //=> 'print, screen'
         */

        /**
         * @memberof AtRule#
         * @member {object} raws - Information to generate byte-to-byte equal
         *                         node string as it was in the origin input.
         *
         * Every parser saves its own properties,
         * but the default CSS parser uses:
         *
         * * `before`: the space symbols before the node. It also stores `*`
         *   and `_` symbols before the declaration (IE hack).
         * * `after`: the space symbols after the last child of the node
         *   to the end of the node.
         * * `between`: the symbols between the property and value
         *   for declarations, selector and `{` for rules, or last parameter
         *   and `{` for at-rules.
         * * `semicolon`: contains true if the last child has
         *   an (optional) semicolon.
         * * `afterName`: the space between the at-rule name and its parameters.
         *
         * PostCSS cleans at-rule parameters from comments and extra spaces,
         * but it stores origin content in raws properties.
         * As such, if you don’t change a declaration’s value,
         * PostCSS will use the raw value with comments.
         *
         * @example
         * const root = postcss.parse('  @media\nprint {\n}')
         * root.first.first.raws //=> { before: '  ',
         *                       //     between: ' ',
         *                       //     afterName: '\n',
         *                       //     after: '\n' }
         */

    }]);

    return AtRule;
}(_container2.default);

exports.default = AtRule;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvYXQtcnVsZS5lczYiXSwibmFtZXMiOlsiQXRSdWxlIiwiZGVmYXVsdHMiLCJ0eXBlIiwiYXBwZW5kIiwibm9kZXMiLCJjaGlsZHJlbiIsInByZXBlbmQiLCJyYXdzIiwiYWZ0ZXJOYW1lIiwidmFsIiwicGFyYW1zIl0sIm1hcHBpbmdzIjoiOzs7Ozs7QUFBQTs7OztBQUNBOzs7Ozs7Ozs7Ozs7QUFFQTs7Ozs7Ozs7Ozs7Ozs7Ozs7O0lBa0JNQSxNOzs7QUFFRixvQkFBWUMsUUFBWixFQUFzQjtBQUFBOztBQUFBLHFEQUNsQixzQkFBTUEsUUFBTixDQURrQjs7QUFFbEIsY0FBS0MsSUFBTCxHQUFZLFFBQVo7QUFGa0I7QUFHckI7O3FCQUVEQyxNLHFCQUFvQjtBQUFBOztBQUNoQixZQUFLLENBQUMsS0FBS0MsS0FBWCxFQUFtQixLQUFLQSxLQUFMLEdBQWEsRUFBYjs7QUFESCwwQ0FBVkMsUUFBVTtBQUFWQSxvQkFBVTtBQUFBOztBQUVoQixlQUFPLDhDQUFNRixNQUFOLGtEQUFnQkUsUUFBaEIsRUFBUDtBQUNILEs7O3FCQUVEQyxPLHNCQUFxQjtBQUFBOztBQUNqQixZQUFLLENBQUMsS0FBS0YsS0FBWCxFQUFtQixLQUFLQSxLQUFMLEdBQWEsRUFBYjs7QUFERiwyQ0FBVkMsUUFBVTtBQUFWQSxvQkFBVTtBQUFBOztBQUVqQixlQUFPLCtDQUFNQyxPQUFOLG1EQUFpQkQsUUFBakIsRUFBUDtBQUNILEs7Ozs7NEJBRWU7QUFDWixvQ0FBUyw0REFBVDtBQUNBLG1CQUFPLEtBQUtFLElBQUwsQ0FBVUMsU0FBakI7QUFDSCxTOzBCQUVhQyxHLEVBQUs7QUFDZixvQ0FBUyw0REFBVDtBQUNBLGlCQUFLRixJQUFMLENBQVVDLFNBQVYsR0FBc0JDLEdBQXRCO0FBQ0g7Ozs0QkFFYTtBQUNWLG9DQUFTLHVEQUFUO0FBQ0EsbUJBQU8sS0FBS0YsSUFBTCxDQUFVRyxNQUFqQjtBQUNILFM7MEJBRVdELEcsRUFBSztBQUNiLG9DQUFTLHVEQUFUO0FBQ0EsaUJBQUtGLElBQUwsQ0FBVUcsTUFBVixHQUFtQkQsR0FBbkI7QUFDSDs7QUFFRDs7Ozs7Ozs7OztBQVVBOzs7Ozs7Ozs7Ozs7QUFZQTs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7OztrQkFpQ1dULE0iLCJmaWxlIjoiYXQtcnVsZS5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBDb250YWluZXIgZnJvbSAnLi9jb250YWluZXInO1xuaW1wb3J0IHdhcm5PbmNlICBmcm9tICcuL3dhcm4tb25jZSc7XG5cbi8qKlxuICogUmVwcmVzZW50cyBhbiBhdC1ydWxlLlxuICpcbiAqIElmIGl04oCZcyBmb2xsb3dlZCBpbiB0aGUgQ1NTIGJ5IGEge30gYmxvY2ssIHRoaXMgbm9kZSB3aWxsIGhhdmVcbiAqIGEgbm9kZXMgcHJvcGVydHkgcmVwcmVzZW50aW5nIGl0cyBjaGlsZHJlbi5cbiAqXG4gKiBAZXh0ZW5kcyBDb250YWluZXJcbiAqXG4gKiBAZXhhbXBsZVxuICogY29uc3Qgcm9vdCA9IHBvc3Rjc3MucGFyc2UoJ0BjaGFyc2V0IFwiVVRGLThcIjsgQG1lZGlhIHByaW50IHt9Jyk7XG4gKlxuICogY29uc3QgY2hhcnNldCA9IHJvb3QuZmlyc3Q7XG4gKiBjaGFyc2V0LnR5cGUgIC8vPT4gJ2F0cnVsZSdcbiAqIGNoYXJzZXQubm9kZXMgLy89PiB1bmRlZmluZWRcbiAqXG4gKiBjb25zdCBtZWRpYSA9IHJvb3QubGFzdDtcbiAqIG1lZGlhLm5vZGVzICAgLy89PiBbXVxuICovXG5jbGFzcyBBdFJ1bGUgZXh0ZW5kcyBDb250YWluZXIge1xuXG4gICAgY29uc3RydWN0b3IoZGVmYXVsdHMpIHtcbiAgICAgICAgc3VwZXIoZGVmYXVsdHMpO1xuICAgICAgICB0aGlzLnR5cGUgPSAnYXRydWxlJztcbiAgICB9XG5cbiAgICBhcHBlbmQoLi4uY2hpbGRyZW4pIHtcbiAgICAgICAgaWYgKCAhdGhpcy5ub2RlcyApIHRoaXMubm9kZXMgPSBbXTtcbiAgICAgICAgcmV0dXJuIHN1cGVyLmFwcGVuZCguLi5jaGlsZHJlbik7XG4gICAgfVxuXG4gICAgcHJlcGVuZCguLi5jaGlsZHJlbikge1xuICAgICAgICBpZiAoICF0aGlzLm5vZGVzICkgdGhpcy5ub2RlcyA9IFtdO1xuICAgICAgICByZXR1cm4gc3VwZXIucHJlcGVuZCguLi5jaGlsZHJlbik7XG4gICAgfVxuXG4gICAgZ2V0IGFmdGVyTmFtZSgpIHtcbiAgICAgICAgd2Fybk9uY2UoJ0F0UnVsZSNhZnRlck5hbWUgd2FzIGRlcHJlY2F0ZWQuIFVzZSBBdFJ1bGUjcmF3cy5hZnRlck5hbWUnKTtcbiAgICAgICAgcmV0dXJuIHRoaXMucmF3cy5hZnRlck5hbWU7XG4gICAgfVxuXG4gICAgc2V0IGFmdGVyTmFtZSh2YWwpIHtcbiAgICAgICAgd2Fybk9uY2UoJ0F0UnVsZSNhZnRlck5hbWUgd2FzIGRlcHJlY2F0ZWQuIFVzZSBBdFJ1bGUjcmF3cy5hZnRlck5hbWUnKTtcbiAgICAgICAgdGhpcy5yYXdzLmFmdGVyTmFtZSA9IHZhbDtcbiAgICB9XG5cbiAgICBnZXQgX3BhcmFtcygpIHtcbiAgICAgICAgd2Fybk9uY2UoJ0F0UnVsZSNfcGFyYW1zIHdhcyBkZXByZWNhdGVkLiBVc2UgQXRSdWxlI3Jhd3MucGFyYW1zJyk7XG4gICAgICAgIHJldHVybiB0aGlzLnJhd3MucGFyYW1zO1xuICAgIH1cblxuICAgIHNldCBfcGFyYW1zKHZhbCkge1xuICAgICAgICB3YXJuT25jZSgnQXRSdWxlI19wYXJhbXMgd2FzIGRlcHJlY2F0ZWQuIFVzZSBBdFJ1bGUjcmF3cy5wYXJhbXMnKTtcbiAgICAgICAgdGhpcy5yYXdzLnBhcmFtcyA9IHZhbDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBAbWVtYmVyb2YgQXRSdWxlI1xuICAgICAqIEBtZW1iZXIge3N0cmluZ30gbmFtZSAtIHRoZSBhdC1ydWxl4oCZcyBuYW1lIGltbWVkaWF0ZWx5IGZvbGxvd3MgdGhlIGBAYFxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBjb25zdCByb290ICA9IHBvc3Rjc3MucGFyc2UoJ0BtZWRpYSBwcmludCB7fScpO1xuICAgICAqIG1lZGlhLm5hbWUgLy89PiAnbWVkaWEnXG4gICAgICogY29uc3QgbWVkaWEgPSByb290LmZpcnN0O1xuICAgICAqL1xuXG4gICAgLyoqXG4gICAgICogQG1lbWJlcm9mIEF0UnVsZSNcbiAgICAgKiBAbWVtYmVyIHtzdHJpbmd9IHBhcmFtcyAtIHRoZSBhdC1ydWxl4oCZcyBwYXJhbWV0ZXJzLCB0aGUgdmFsdWVzXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICB0aGF0IGZvbGxvdyB0aGUgYXQtcnVsZeKAmXMgbmFtZSBidXQgcHJlY2VkZVxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgYW55IHt9IGJsb2NrXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGNvbnN0IHJvb3QgID0gcG9zdGNzcy5wYXJzZSgnQG1lZGlhIHByaW50LCBzY3JlZW4ge30nKTtcbiAgICAgKiBjb25zdCBtZWRpYSA9IHJvb3QuZmlyc3Q7XG4gICAgICogbWVkaWEucGFyYW1zIC8vPT4gJ3ByaW50LCBzY3JlZW4nXG4gICAgICovXG5cbiAgICAvKipcbiAgICAgKiBAbWVtYmVyb2YgQXRSdWxlI1xuICAgICAqIEBtZW1iZXIge29iamVjdH0gcmF3cyAtIEluZm9ybWF0aW9uIHRvIGdlbmVyYXRlIGJ5dGUtdG8tYnl0ZSBlcXVhbFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgIG5vZGUgc3RyaW5nIGFzIGl0IHdhcyBpbiB0aGUgb3JpZ2luIGlucHV0LlxuICAgICAqXG4gICAgICogRXZlcnkgcGFyc2VyIHNhdmVzIGl0cyBvd24gcHJvcGVydGllcyxcbiAgICAgKiBidXQgdGhlIGRlZmF1bHQgQ1NTIHBhcnNlciB1c2VzOlxuICAgICAqXG4gICAgICogKiBgYmVmb3JlYDogdGhlIHNwYWNlIHN5bWJvbHMgYmVmb3JlIHRoZSBub2RlLiBJdCBhbHNvIHN0b3JlcyBgKmBcbiAgICAgKiAgIGFuZCBgX2Agc3ltYm9scyBiZWZvcmUgdGhlIGRlY2xhcmF0aW9uIChJRSBoYWNrKS5cbiAgICAgKiAqIGBhZnRlcmA6IHRoZSBzcGFjZSBzeW1ib2xzIGFmdGVyIHRoZSBsYXN0IGNoaWxkIG9mIHRoZSBub2RlXG4gICAgICogICB0byB0aGUgZW5kIG9mIHRoZSBub2RlLlxuICAgICAqICogYGJldHdlZW5gOiB0aGUgc3ltYm9scyBiZXR3ZWVuIHRoZSBwcm9wZXJ0eSBhbmQgdmFsdWVcbiAgICAgKiAgIGZvciBkZWNsYXJhdGlvbnMsIHNlbGVjdG9yIGFuZCBge2AgZm9yIHJ1bGVzLCBvciBsYXN0IHBhcmFtZXRlclxuICAgICAqICAgYW5kIGB7YCBmb3IgYXQtcnVsZXMuXG4gICAgICogKiBgc2VtaWNvbG9uYDogY29udGFpbnMgdHJ1ZSBpZiB0aGUgbGFzdCBjaGlsZCBoYXNcbiAgICAgKiAgIGFuIChvcHRpb25hbCkgc2VtaWNvbG9uLlxuICAgICAqICogYGFmdGVyTmFtZWA6IHRoZSBzcGFjZSBiZXR3ZWVuIHRoZSBhdC1ydWxlIG5hbWUgYW5kIGl0cyBwYXJhbWV0ZXJzLlxuICAgICAqXG4gICAgICogUG9zdENTUyBjbGVhbnMgYXQtcnVsZSBwYXJhbWV0ZXJzIGZyb20gY29tbWVudHMgYW5kIGV4dHJhIHNwYWNlcyxcbiAgICAgKiBidXQgaXQgc3RvcmVzIG9yaWdpbiBjb250ZW50IGluIHJhd3MgcHJvcGVydGllcy5cbiAgICAgKiBBcyBzdWNoLCBpZiB5b3UgZG9u4oCZdCBjaGFuZ2UgYSBkZWNsYXJhdGlvbuKAmXMgdmFsdWUsXG4gICAgICogUG9zdENTUyB3aWxsIHVzZSB0aGUgcmF3IHZhbHVlIHdpdGggY29tbWVudHMuXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKCcgIEBtZWRpYVxcbnByaW50IHtcXG59JylcbiAgICAgKiByb290LmZpcnN0LmZpcnN0LnJhd3MgLy89PiB7IGJlZm9yZTogJyAgJyxcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgLy8gICAgIGJldHdlZW46ICcgJyxcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgLy8gICAgIGFmdGVyTmFtZTogJ1xcbicsXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgIC8vICAgICBhZnRlcjogJ1xcbicgfVxuICAgICAqL1xufVxuXG5leHBvcnQgZGVmYXVsdCBBdFJ1bGU7XG4iXX0=
