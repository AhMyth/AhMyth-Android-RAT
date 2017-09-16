'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _warnOnce = require('./warn-once');

var _warnOnce2 = _interopRequireDefault(_warnOnce);

var _node = require('./node');

var _node2 = _interopRequireDefault(_node);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

/**
 * Represents a comment between declarations or statements (rule and at-rules).
 *
 * Comments inside selectors, at-rule parameters, or declaration values
 * will be stored in the `raws` properties explained above.
 *
 * @extends Node
 */
var Comment = function (_Node) {
    _inherits(Comment, _Node);

    function Comment(defaults) {
        _classCallCheck(this, Comment);

        var _this = _possibleConstructorReturn(this, _Node.call(this, defaults));

        _this.type = 'comment';
        return _this;
    }

    _createClass(Comment, [{
        key: 'left',
        get: function get() {
            (0, _warnOnce2.default)('Comment#left was deprecated. Use Comment#raws.left');
            return this.raws.left;
        },
        set: function set(val) {
            (0, _warnOnce2.default)('Comment#left was deprecated. Use Comment#raws.left');
            this.raws.left = val;
        }
    }, {
        key: 'right',
        get: function get() {
            (0, _warnOnce2.default)('Comment#right was deprecated. Use Comment#raws.right');
            return this.raws.right;
        },
        set: function set(val) {
            (0, _warnOnce2.default)('Comment#right was deprecated. Use Comment#raws.right');
            this.raws.right = val;
        }

        /**
         * @memberof Comment#
         * @member {string} text - the comment’s text
         */

        /**
         * @memberof Comment#
         * @member {object} raws - Information to generate byte-to-byte equal
         *                         node string as it was in the origin input.
         *
         * Every parser saves its own properties,
         * but the default CSS parser uses:
         *
         * * `before`: the space symbols before the node.
         * * `left`: the space symbols between `/*` and the comment’s text.
         * * `right`: the space symbols between the comment’s text.
         */

    }]);

    return Comment;
}(_node2.default);

exports.default = Comment;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvY29tbWVudC5lczYiXSwibmFtZXMiOlsiQ29tbWVudCIsImRlZmF1bHRzIiwidHlwZSIsInJhd3MiLCJsZWZ0IiwidmFsIiwicmlnaHQiXSwibWFwcGluZ3MiOiI7Ozs7OztBQUFBOzs7O0FBQ0E7Ozs7Ozs7Ozs7OztBQUVBOzs7Ozs7OztJQVFNQSxPOzs7QUFFRixxQkFBWUMsUUFBWixFQUFzQjtBQUFBOztBQUFBLHFEQUNsQixpQkFBTUEsUUFBTixDQURrQjs7QUFFbEIsY0FBS0MsSUFBTCxHQUFZLFNBQVo7QUFGa0I7QUFHckI7Ozs7NEJBRVU7QUFDUCxvQ0FBUyxvREFBVDtBQUNBLG1CQUFPLEtBQUtDLElBQUwsQ0FBVUMsSUFBakI7QUFDSCxTOzBCQUVRQyxHLEVBQUs7QUFDVixvQ0FBUyxvREFBVDtBQUNBLGlCQUFLRixJQUFMLENBQVVDLElBQVYsR0FBaUJDLEdBQWpCO0FBQ0g7Ozs0QkFFVztBQUNSLG9DQUFTLHNEQUFUO0FBQ0EsbUJBQU8sS0FBS0YsSUFBTCxDQUFVRyxLQUFqQjtBQUNILFM7MEJBRVNELEcsRUFBSztBQUNYLG9DQUFTLHNEQUFUO0FBQ0EsaUJBQUtGLElBQUwsQ0FBVUcsS0FBVixHQUFrQkQsR0FBbEI7QUFDSDs7QUFFRDs7Ozs7QUFLQTs7Ozs7Ozs7Ozs7Ozs7Ozs7O2tCQWNXTCxPIiwiZmlsZSI6ImNvbW1lbnQuanMiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgd2Fybk9uY2UgZnJvbSAnLi93YXJuLW9uY2UnO1xuaW1wb3J0IE5vZGUgICAgIGZyb20gJy4vbm9kZSc7XG5cbi8qKlxuICogUmVwcmVzZW50cyBhIGNvbW1lbnQgYmV0d2VlbiBkZWNsYXJhdGlvbnMgb3Igc3RhdGVtZW50cyAocnVsZSBhbmQgYXQtcnVsZXMpLlxuICpcbiAqIENvbW1lbnRzIGluc2lkZSBzZWxlY3RvcnMsIGF0LXJ1bGUgcGFyYW1ldGVycywgb3IgZGVjbGFyYXRpb24gdmFsdWVzXG4gKiB3aWxsIGJlIHN0b3JlZCBpbiB0aGUgYHJhd3NgIHByb3BlcnRpZXMgZXhwbGFpbmVkIGFib3ZlLlxuICpcbiAqIEBleHRlbmRzIE5vZGVcbiAqL1xuY2xhc3MgQ29tbWVudCBleHRlbmRzIE5vZGUge1xuXG4gICAgY29uc3RydWN0b3IoZGVmYXVsdHMpIHtcbiAgICAgICAgc3VwZXIoZGVmYXVsdHMpO1xuICAgICAgICB0aGlzLnR5cGUgPSAnY29tbWVudCc7XG4gICAgfVxuXG4gICAgZ2V0IGxlZnQoKSB7XG4gICAgICAgIHdhcm5PbmNlKCdDb21tZW50I2xlZnQgd2FzIGRlcHJlY2F0ZWQuIFVzZSBDb21tZW50I3Jhd3MubGVmdCcpO1xuICAgICAgICByZXR1cm4gdGhpcy5yYXdzLmxlZnQ7XG4gICAgfVxuXG4gICAgc2V0IGxlZnQodmFsKSB7XG4gICAgICAgIHdhcm5PbmNlKCdDb21tZW50I2xlZnQgd2FzIGRlcHJlY2F0ZWQuIFVzZSBDb21tZW50I3Jhd3MubGVmdCcpO1xuICAgICAgICB0aGlzLnJhd3MubGVmdCA9IHZhbDtcbiAgICB9XG5cbiAgICBnZXQgcmlnaHQoKSB7XG4gICAgICAgIHdhcm5PbmNlKCdDb21tZW50I3JpZ2h0IHdhcyBkZXByZWNhdGVkLiBVc2UgQ29tbWVudCNyYXdzLnJpZ2h0Jyk7XG4gICAgICAgIHJldHVybiB0aGlzLnJhd3MucmlnaHQ7XG4gICAgfVxuXG4gICAgc2V0IHJpZ2h0KHZhbCkge1xuICAgICAgICB3YXJuT25jZSgnQ29tbWVudCNyaWdodCB3YXMgZGVwcmVjYXRlZC4gVXNlIENvbW1lbnQjcmF3cy5yaWdodCcpO1xuICAgICAgICB0aGlzLnJhd3MucmlnaHQgPSB2YWw7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogQG1lbWJlcm9mIENvbW1lbnQjXG4gICAgICogQG1lbWJlciB7c3RyaW5nfSB0ZXh0IC0gdGhlIGNvbW1lbnTigJlzIHRleHRcbiAgICAgKi9cblxuICAgIC8qKlxuICAgICAqIEBtZW1iZXJvZiBDb21tZW50I1xuICAgICAqIEBtZW1iZXIge29iamVjdH0gcmF3cyAtIEluZm9ybWF0aW9uIHRvIGdlbmVyYXRlIGJ5dGUtdG8tYnl0ZSBlcXVhbFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgIG5vZGUgc3RyaW5nIGFzIGl0IHdhcyBpbiB0aGUgb3JpZ2luIGlucHV0LlxuICAgICAqXG4gICAgICogRXZlcnkgcGFyc2VyIHNhdmVzIGl0cyBvd24gcHJvcGVydGllcyxcbiAgICAgKiBidXQgdGhlIGRlZmF1bHQgQ1NTIHBhcnNlciB1c2VzOlxuICAgICAqXG4gICAgICogKiBgYmVmb3JlYDogdGhlIHNwYWNlIHN5bWJvbHMgYmVmb3JlIHRoZSBub2RlLlxuICAgICAqICogYGxlZnRgOiB0aGUgc3BhY2Ugc3ltYm9scyBiZXR3ZWVuIGAvKmAgYW5kIHRoZSBjb21tZW504oCZcyB0ZXh0LlxuICAgICAqICogYHJpZ2h0YDogdGhlIHNwYWNlIHN5bWJvbHMgYmV0d2VlbiB0aGUgY29tbWVudOKAmXMgdGV4dC5cbiAgICAgKi9cbn1cblxuZXhwb3J0IGRlZmF1bHQgQ29tbWVudDtcbiJdfQ==
