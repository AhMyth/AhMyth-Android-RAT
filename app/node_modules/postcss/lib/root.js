'use strict';

exports.__esModule = true;

var _container = require('./container');

var _container2 = _interopRequireDefault(_container);

var _warnOnce = require('./warn-once');

var _warnOnce2 = _interopRequireDefault(_warnOnce);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

/**
 * Represents a CSS file and contains all its parsed nodes.
 *
 * @extends Container
 *
 * @example
 * const root = postcss.parse('a{color:black} b{z-index:2}');
 * root.type         //=> 'root'
 * root.nodes.length //=> 2
 */
var Root = function (_Container) {
    _inherits(Root, _Container);

    function Root(defaults) {
        _classCallCheck(this, Root);

        var _this = _possibleConstructorReturn(this, _Container.call(this, defaults));

        _this.type = 'root';
        if (!_this.nodes) _this.nodes = [];
        return _this;
    }

    Root.prototype.removeChild = function removeChild(child) {
        child = this.index(child);

        if (child === 0 && this.nodes.length > 1) {
            this.nodes[1].raws.before = this.nodes[child].raws.before;
        }

        return _Container.prototype.removeChild.call(this, child);
    };

    Root.prototype.normalize = function normalize(child, sample, type) {
        var nodes = _Container.prototype.normalize.call(this, child);

        if (sample) {
            if (type === 'prepend') {
                if (this.nodes.length > 1) {
                    sample.raws.before = this.nodes[1].raws.before;
                } else {
                    delete sample.raws.before;
                }
            } else if (this.first !== sample) {
                for (var _iterator = nodes, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
                    var _ref;

                    if (_isArray) {
                        if (_i >= _iterator.length) break;
                        _ref = _iterator[_i++];
                    } else {
                        _i = _iterator.next();
                        if (_i.done) break;
                        _ref = _i.value;
                    }

                    var node = _ref;

                    node.raws.before = sample.raws.before;
                }
            }
        }

        return nodes;
    };

    /**
     * Returns a {@link Result} instance representing the root’s CSS.
     *
     * @param {processOptions} [opts] - options with only `to` and `map` keys
     *
     * @return {Result} result with current root’s CSS
     *
     * @example
     * const root1 = postcss.parse(css1, { from: 'a.css' });
     * const root2 = postcss.parse(css2, { from: 'b.css' });
     * root1.append(root2);
     * const result = root1.toResult({ to: 'all.css', map: true });
     */


    Root.prototype.toResult = function toResult() {
        var opts = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

        var LazyResult = require('./lazy-result');
        var Processor = require('./processor');

        var lazy = new LazyResult(new Processor(), this, opts);
        return lazy.stringify();
    };

    Root.prototype.remove = function remove(child) {
        (0, _warnOnce2.default)('Root#remove is deprecated. Use Root#removeChild');
        this.removeChild(child);
    };

    Root.prototype.prevMap = function prevMap() {
        (0, _warnOnce2.default)('Root#prevMap is deprecated. Use Root#source.input.map');
        return this.source.input.map;
    };

    /**
     * @memberof Root#
     * @member {object} raws - Information to generate byte-to-byte equal
     *                         node string as it was in the origin input.
     *
     * Every parser saves its own properties,
     * but the default CSS parser uses:
     *
     * * `after`: the space symbols after the last child to the end of file.
     * * `semicolon`: is the last child has an (optional) semicolon.
     *
     * @example
     * postcss.parse('a {}\n').raws //=> { after: '\n' }
     * postcss.parse('a {}').raws   //=> { after: '' }
     */

    return Root;
}(_container2.default);

exports.default = Root;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvcm9vdC5lczYiXSwibmFtZXMiOlsiUm9vdCIsImRlZmF1bHRzIiwidHlwZSIsIm5vZGVzIiwicmVtb3ZlQ2hpbGQiLCJjaGlsZCIsImluZGV4IiwibGVuZ3RoIiwicmF3cyIsImJlZm9yZSIsIm5vcm1hbGl6ZSIsInNhbXBsZSIsImZpcnN0Iiwibm9kZSIsInRvUmVzdWx0Iiwib3B0cyIsIkxhenlSZXN1bHQiLCJyZXF1aXJlIiwiUHJvY2Vzc29yIiwibGF6eSIsInN0cmluZ2lmeSIsInJlbW92ZSIsInByZXZNYXAiLCJzb3VyY2UiLCJpbnB1dCIsIm1hcCJdLCJtYXBwaW5ncyI6Ijs7OztBQUFBOzs7O0FBQ0E7Ozs7Ozs7Ozs7OztBQUVBOzs7Ozs7Ozs7O0lBVU1BLEk7OztBQUVGLGtCQUFZQyxRQUFaLEVBQXNCO0FBQUE7O0FBQUEscURBQ2xCLHNCQUFNQSxRQUFOLENBRGtCOztBQUVsQixjQUFLQyxJQUFMLEdBQVksTUFBWjtBQUNBLFlBQUssQ0FBQyxNQUFLQyxLQUFYLEVBQW1CLE1BQUtBLEtBQUwsR0FBYSxFQUFiO0FBSEQ7QUFJckI7O21CQUVEQyxXLHdCQUFZQyxLLEVBQU87QUFDZkEsZ0JBQVEsS0FBS0MsS0FBTCxDQUFXRCxLQUFYLENBQVI7O0FBRUEsWUFBS0EsVUFBVSxDQUFWLElBQWUsS0FBS0YsS0FBTCxDQUFXSSxNQUFYLEdBQW9CLENBQXhDLEVBQTRDO0FBQ3hDLGlCQUFLSixLQUFMLENBQVcsQ0FBWCxFQUFjSyxJQUFkLENBQW1CQyxNQUFuQixHQUE0QixLQUFLTixLQUFMLENBQVdFLEtBQVgsRUFBa0JHLElBQWxCLENBQXVCQyxNQUFuRDtBQUNIOztBQUVELGVBQU8scUJBQU1MLFdBQU4sWUFBa0JDLEtBQWxCLENBQVA7QUFDSCxLOzttQkFFREssUyxzQkFBVUwsSyxFQUFPTSxNLEVBQVFULEksRUFBTTtBQUMzQixZQUFJQyxRQUFRLHFCQUFNTyxTQUFOLFlBQWdCTCxLQUFoQixDQUFaOztBQUVBLFlBQUtNLE1BQUwsRUFBYztBQUNWLGdCQUFLVCxTQUFTLFNBQWQsRUFBMEI7QUFDdEIsb0JBQUssS0FBS0MsS0FBTCxDQUFXSSxNQUFYLEdBQW9CLENBQXpCLEVBQTZCO0FBQ3pCSSwyQkFBT0gsSUFBUCxDQUFZQyxNQUFaLEdBQXFCLEtBQUtOLEtBQUwsQ0FBVyxDQUFYLEVBQWNLLElBQWQsQ0FBbUJDLE1BQXhDO0FBQ0gsaUJBRkQsTUFFTztBQUNILDJCQUFPRSxPQUFPSCxJQUFQLENBQVlDLE1BQW5CO0FBQ0g7QUFDSixhQU5ELE1BTU8sSUFBSyxLQUFLRyxLQUFMLEtBQWVELE1BQXBCLEVBQTZCO0FBQ2hDLHFDQUFrQlIsS0FBbEIsa0hBQTBCO0FBQUE7O0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTs7QUFBQSx3QkFBaEJVLElBQWdCOztBQUN0QkEseUJBQUtMLElBQUwsQ0FBVUMsTUFBVixHQUFtQkUsT0FBT0gsSUFBUCxDQUFZQyxNQUEvQjtBQUNIO0FBQ0o7QUFDSjs7QUFFRCxlQUFPTixLQUFQO0FBQ0gsSzs7QUFFRDs7Ozs7Ozs7Ozs7Ozs7O21CQWFBVyxRLHVCQUFxQjtBQUFBLFlBQVpDLElBQVksdUVBQUwsRUFBSzs7QUFDakIsWUFBSUMsYUFBYUMsUUFBUSxlQUFSLENBQWpCO0FBQ0EsWUFBSUMsWUFBYUQsUUFBUSxhQUFSLENBQWpCOztBQUVBLFlBQUlFLE9BQU8sSUFBSUgsVUFBSixDQUFlLElBQUlFLFNBQUosRUFBZixFQUFnQyxJQUFoQyxFQUFzQ0gsSUFBdEMsQ0FBWDtBQUNBLGVBQU9JLEtBQUtDLFNBQUwsRUFBUDtBQUNILEs7O21CQUVEQyxNLG1CQUFPaEIsSyxFQUFPO0FBQ1YsZ0NBQVMsaURBQVQ7QUFDQSxhQUFLRCxXQUFMLENBQWlCQyxLQUFqQjtBQUNILEs7O21CQUVEaUIsTyxzQkFBVTtBQUNOLGdDQUFTLHVEQUFUO0FBQ0EsZUFBTyxLQUFLQyxNQUFMLENBQVlDLEtBQVosQ0FBa0JDLEdBQXpCO0FBQ0gsSzs7QUFFRDs7Ozs7Ozs7Ozs7Ozs7Ozs7OztrQkFrQld6QixJIiwiZmlsZSI6InJvb3QuanMiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgQ29udGFpbmVyIGZyb20gJy4vY29udGFpbmVyJztcbmltcG9ydCB3YXJuT25jZSAgZnJvbSAnLi93YXJuLW9uY2UnO1xuXG4vKipcbiAqIFJlcHJlc2VudHMgYSBDU1MgZmlsZSBhbmQgY29udGFpbnMgYWxsIGl0cyBwYXJzZWQgbm9kZXMuXG4gKlxuICogQGV4dGVuZHMgQ29udGFpbmVyXG4gKlxuICogQGV4YW1wbGVcbiAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKCdhe2NvbG9yOmJsYWNrfSBie3otaW5kZXg6Mn0nKTtcbiAqIHJvb3QudHlwZSAgICAgICAgIC8vPT4gJ3Jvb3QnXG4gKiByb290Lm5vZGVzLmxlbmd0aCAvLz0+IDJcbiAqL1xuY2xhc3MgUm9vdCBleHRlbmRzIENvbnRhaW5lciB7XG5cbiAgICBjb25zdHJ1Y3RvcihkZWZhdWx0cykge1xuICAgICAgICBzdXBlcihkZWZhdWx0cyk7XG4gICAgICAgIHRoaXMudHlwZSA9ICdyb290JztcbiAgICAgICAgaWYgKCAhdGhpcy5ub2RlcyApIHRoaXMubm9kZXMgPSBbXTtcbiAgICB9XG5cbiAgICByZW1vdmVDaGlsZChjaGlsZCkge1xuICAgICAgICBjaGlsZCA9IHRoaXMuaW5kZXgoY2hpbGQpO1xuXG4gICAgICAgIGlmICggY2hpbGQgPT09IDAgJiYgdGhpcy5ub2Rlcy5sZW5ndGggPiAxICkge1xuICAgICAgICAgICAgdGhpcy5ub2Rlc1sxXS5yYXdzLmJlZm9yZSA9IHRoaXMubm9kZXNbY2hpbGRdLnJhd3MuYmVmb3JlO1xuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIHN1cGVyLnJlbW92ZUNoaWxkKGNoaWxkKTtcbiAgICB9XG5cbiAgICBub3JtYWxpemUoY2hpbGQsIHNhbXBsZSwgdHlwZSkge1xuICAgICAgICBsZXQgbm9kZXMgPSBzdXBlci5ub3JtYWxpemUoY2hpbGQpO1xuXG4gICAgICAgIGlmICggc2FtcGxlICkge1xuICAgICAgICAgICAgaWYgKCB0eXBlID09PSAncHJlcGVuZCcgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCB0aGlzLm5vZGVzLmxlbmd0aCA+IDEgKSB7XG4gICAgICAgICAgICAgICAgICAgIHNhbXBsZS5yYXdzLmJlZm9yZSA9IHRoaXMubm9kZXNbMV0ucmF3cy5iZWZvcmU7XG4gICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgZGVsZXRlIHNhbXBsZS5yYXdzLmJlZm9yZTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9IGVsc2UgaWYgKCB0aGlzLmZpcnN0ICE9PSBzYW1wbGUgKSB7XG4gICAgICAgICAgICAgICAgZm9yICggbGV0IG5vZGUgb2Ygbm9kZXMgKSB7XG4gICAgICAgICAgICAgICAgICAgIG5vZGUucmF3cy5iZWZvcmUgPSBzYW1wbGUucmF3cy5iZWZvcmU7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIG5vZGVzO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIFJldHVybnMgYSB7QGxpbmsgUmVzdWx0fSBpbnN0YW5jZSByZXByZXNlbnRpbmcgdGhlIHJvb3TigJlzIENTUy5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7cHJvY2Vzc09wdGlvbnN9IFtvcHRzXSAtIG9wdGlvbnMgd2l0aCBvbmx5IGB0b2AgYW5kIGBtYXBgIGtleXNcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge1Jlc3VsdH0gcmVzdWx0IHdpdGggY3VycmVudCByb2904oCZcyBDU1NcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogY29uc3Qgcm9vdDEgPSBwb3N0Y3NzLnBhcnNlKGNzczEsIHsgZnJvbTogJ2EuY3NzJyB9KTtcbiAgICAgKiBjb25zdCByb290MiA9IHBvc3Rjc3MucGFyc2UoY3NzMiwgeyBmcm9tOiAnYi5jc3MnIH0pO1xuICAgICAqIHJvb3QxLmFwcGVuZChyb290Mik7XG4gICAgICogY29uc3QgcmVzdWx0ID0gcm9vdDEudG9SZXN1bHQoeyB0bzogJ2FsbC5jc3MnLCBtYXA6IHRydWUgfSk7XG4gICAgICovXG4gICAgdG9SZXN1bHQob3B0cyA9IHsgfSkge1xuICAgICAgICBsZXQgTGF6eVJlc3VsdCA9IHJlcXVpcmUoJy4vbGF6eS1yZXN1bHQnKTtcbiAgICAgICAgbGV0IFByb2Nlc3NvciAgPSByZXF1aXJlKCcuL3Byb2Nlc3NvcicpO1xuXG4gICAgICAgIGxldCBsYXp5ID0gbmV3IExhenlSZXN1bHQobmV3IFByb2Nlc3NvcigpLCB0aGlzLCBvcHRzKTtcbiAgICAgICAgcmV0dXJuIGxhenkuc3RyaW5naWZ5KCk7XG4gICAgfVxuXG4gICAgcmVtb3ZlKGNoaWxkKSB7XG4gICAgICAgIHdhcm5PbmNlKCdSb290I3JlbW92ZSBpcyBkZXByZWNhdGVkLiBVc2UgUm9vdCNyZW1vdmVDaGlsZCcpO1xuICAgICAgICB0aGlzLnJlbW92ZUNoaWxkKGNoaWxkKTtcbiAgICB9XG5cbiAgICBwcmV2TWFwKCkge1xuICAgICAgICB3YXJuT25jZSgnUm9vdCNwcmV2TWFwIGlzIGRlcHJlY2F0ZWQuIFVzZSBSb290I3NvdXJjZS5pbnB1dC5tYXAnKTtcbiAgICAgICAgcmV0dXJuIHRoaXMuc291cmNlLmlucHV0Lm1hcDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBAbWVtYmVyb2YgUm9vdCNcbiAgICAgKiBAbWVtYmVyIHtvYmplY3R9IHJhd3MgLSBJbmZvcm1hdGlvbiB0byBnZW5lcmF0ZSBieXRlLXRvLWJ5dGUgZXF1YWxcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICBub2RlIHN0cmluZyBhcyBpdCB3YXMgaW4gdGhlIG9yaWdpbiBpbnB1dC5cbiAgICAgKlxuICAgICAqIEV2ZXJ5IHBhcnNlciBzYXZlcyBpdHMgb3duIHByb3BlcnRpZXMsXG4gICAgICogYnV0IHRoZSBkZWZhdWx0IENTUyBwYXJzZXIgdXNlczpcbiAgICAgKlxuICAgICAqICogYGFmdGVyYDogdGhlIHNwYWNlIHN5bWJvbHMgYWZ0ZXIgdGhlIGxhc3QgY2hpbGQgdG8gdGhlIGVuZCBvZiBmaWxlLlxuICAgICAqICogYHNlbWljb2xvbmA6IGlzIHRoZSBsYXN0IGNoaWxkIGhhcyBhbiAob3B0aW9uYWwpIHNlbWljb2xvbi5cbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcG9zdGNzcy5wYXJzZSgnYSB7fVxcbicpLnJhd3MgLy89PiB7IGFmdGVyOiAnXFxuJyB9XG4gICAgICogcG9zdGNzcy5wYXJzZSgnYSB7fScpLnJhd3MgICAvLz0+IHsgYWZ0ZXI6ICcnIH1cbiAgICAgKi9cblxufVxuXG5leHBvcnQgZGVmYXVsdCBSb290O1xuIl19
