'use strict';

exports.__esModule = true;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

var _cssSyntaxError = require('./css-syntax-error');

var _cssSyntaxError2 = _interopRequireDefault(_cssSyntaxError);

var _stringifier = require('./stringifier');

var _stringifier2 = _interopRequireDefault(_stringifier);

var _stringify = require('./stringify');

var _stringify2 = _interopRequireDefault(_stringify);

var _warnOnce = require('./warn-once');

var _warnOnce2 = _interopRequireDefault(_warnOnce);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var cloneNode = function cloneNode(obj, parent) {
    var cloned = new obj.constructor();

    for (var i in obj) {
        if (!obj.hasOwnProperty(i)) continue;
        var value = obj[i];
        var type = typeof value === 'undefined' ? 'undefined' : _typeof(value);

        if (i === 'parent' && type === 'object') {
            if (parent) cloned[i] = parent;
        } else if (i === 'source') {
            cloned[i] = value;
        } else if (value instanceof Array) {
            cloned[i] = value.map(function (j) {
                return cloneNode(j, cloned);
            });
        } else if (i !== 'before' && i !== 'after' && i !== 'between' && i !== 'semicolon') {
            if (type === 'object' && value !== null) value = cloneNode(value);
            cloned[i] = value;
        }
    }

    return cloned;
};

/**
 * All node classes inherit the following common methods.
 *
 * @abstract
 */

var Node = function () {

    /**
     * @param {object} [defaults] - value for node properties
     */
    function Node() {
        var defaults = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

        _classCallCheck(this, Node);

        this.raws = {};
        for (var name in defaults) {
            this[name] = defaults[name];
        }
    }

    /**
     * Returns a CssSyntaxError instance containing the original position
     * of the node in the source, showing line and column numbers and also
     * a small excerpt to facilitate debugging.
     *
     * If present, an input source map will be used to get the original position
     * of the source, even from a previous compilation step
     * (e.g., from Sass compilation).
     *
     * This method produces very useful error messages.
     *
     * @param {string} message     - error description
     * @param {object} [opts]      - options
     * @param {string} opts.plugin - plugin name that created this error.
     *                               PostCSS will set it automatically.
     * @param {string} opts.word   - a word inside a node’s string that should
     *                               be highlighted as the source of the error
     * @param {number} opts.index  - an index inside a node’s string that should
     *                               be highlighted as the source of the error
     *
     * @return {CssSyntaxError} error object to throw it
     *
     * @example
     * if ( !variables[name] ) {
     *   throw decl.error('Unknown variable ' + name, { word: name });
     *   // CssSyntaxError: postcss-vars:a.sass:4:3: Unknown variable $black
     *   //   color: $black
     *   // a
     *   //          ^
     *   //   background: white
     * }
     */


    Node.prototype.error = function error(message) {
        var opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        if (this.source) {
            var pos = this.positionBy(opts);
            return this.source.input.error(message, pos.line, pos.column, opts);
        } else {
            return new _cssSyntaxError2.default(message);
        }
    };

    /**
     * This method is provided as a convenience wrapper for {@link Result#warn}.
     *
     * @param {Result} result      - the {@link Result} instance
     *                               that will receive the warning
     * @param {string} text        - warning message
     * @param {object} [opts]      - options
     * @param {string} opts.plugin - plugin name that created this warning.
     *                               PostCSS will set it automatically.
     * @param {string} opts.word   - a word inside a node’s string that should
     *                               be highlighted as the source of the warning
     * @param {number} opts.index  - an index inside a node’s string that should
     *                               be highlighted as the source of the warning
     *
     * @return {Warning} created warning object
     *
     * @example
     * const plugin = postcss.plugin('postcss-deprecated', () => {
     *   return (root, result) => {
     *     root.walkDecls('bad', decl => {
     *       decl.warn(result, 'Deprecated property bad');
     *     });
     *   };
     * });
     */


    Node.prototype.warn = function warn(result, text, opts) {
        var data = { node: this };
        for (var i in opts) {
            data[i] = opts[i];
        }return result.warn(text, data);
    };

    /**
     * Removes the node from its parent and cleans the parent properties
     * from the node and its children.
     *
     * @example
     * if ( decl.prop.match(/^-webkit-/) ) {
     *   decl.remove();
     * }
     *
     * @return {Node} node to make calls chain
     */


    Node.prototype.remove = function remove() {
        if (this.parent) {
            this.parent.removeChild(this);
        }
        this.parent = undefined;
        return this;
    };

    /**
     * Returns a CSS string representing the node.
     *
     * @param {stringifier|syntax} [stringifier] - a syntax to use
     *                                             in string generation
     *
     * @return {string} CSS string of this node
     *
     * @example
     * postcss.rule({ selector: 'a' }).toString() //=> "a {}"
     */


    Node.prototype.toString = function toString() {
        var stringifier = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : _stringify2.default;

        if (stringifier.stringify) stringifier = stringifier.stringify;
        var result = '';
        stringifier(this, function (i) {
            result += i;
        });
        return result;
    };

    /**
     * Returns a clone of the node.
     *
     * The resulting cloned node and its (cloned) children will have
     * a clean parent and code style properties.
     *
     * @param {object} [overrides] - new properties to override in the clone.
     *
     * @example
     * const cloned = decl.clone({ prop: '-moz-' + decl.prop });
     * cloned.raws.before  //=> undefined
     * cloned.parent       //=> undefined
     * cloned.toString()   //=> -moz-transform: scale(0)
     *
     * @return {Node} clone of the node
     */


    Node.prototype.clone = function clone() {
        var overrides = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

        var cloned = cloneNode(this);
        for (var name in overrides) {
            cloned[name] = overrides[name];
        }
        return cloned;
    };

    /**
     * Shortcut to clone the node and insert the resulting cloned node
     * before the current node.
     *
     * @param {object} [overrides] - new properties to override in the clone.
     *
     * @example
     * decl.cloneBefore({ prop: '-moz-' + decl.prop });
     *
     * @return {Node} - new node
     */


    Node.prototype.cloneBefore = function cloneBefore() {
        var overrides = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

        var cloned = this.clone(overrides);
        this.parent.insertBefore(this, cloned);
        return cloned;
    };

    /**
     * Shortcut to clone the node and insert the resulting cloned node
     * after the current node.
     *
     * @param {object} [overrides] - new properties to override in the clone.
     *
     * @return {Node} - new node
     */


    Node.prototype.cloneAfter = function cloneAfter() {
        var overrides = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

        var cloned = this.clone(overrides);
        this.parent.insertAfter(this, cloned);
        return cloned;
    };

    /**
     * Inserts node(s) before the current node and removes the current node.
     *
     * @param {...Node} nodes - node(s) to replace current one
     *
     * @example
     * if ( atrule.name == 'mixin' ) {
     *   atrule.replaceWith(mixinRules[atrule.params]);
     * }
     *
     * @return {Node} current node to methods chain
     */


    Node.prototype.replaceWith = function replaceWith() {
        if (this.parent) {
            for (var _len = arguments.length, nodes = Array(_len), _key = 0; _key < _len; _key++) {
                nodes[_key] = arguments[_key];
            }

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

                this.parent.insertBefore(this, node);
            }

            this.remove();
        }

        return this;
    };

    /**
     * Removes the node from its current parent and inserts it
     * at the end of `newParent`.
     *
     * This will clean the `before` and `after` code {@link Node#raws} data
     * from the node and replace them with the indentation style of `newParent`.
     * It will also clean the `between` property
     * if `newParent` is in another {@link Root}.
     *
     * @param {Container} newParent - container node where the current node
     *                                will be moved
     *
     * @example
     * atrule.moveTo(atrule.root());
     *
     * @return {Node} current node to methods chain
     */


    Node.prototype.moveTo = function moveTo(newParent) {
        this.cleanRaws(this.root() === newParent.root());
        this.remove();
        newParent.append(this);
        return this;
    };

    /**
     * Removes the node from its current parent and inserts it into
     * a new parent before `otherNode`.
     *
     * This will also clean the node’s code style properties just as it would
     * in {@link Node#moveTo}.
     *
     * @param {Node} otherNode - node that will be before current node
     *
     * @return {Node} current node to methods chain
     */


    Node.prototype.moveBefore = function moveBefore(otherNode) {
        this.cleanRaws(this.root() === otherNode.root());
        this.remove();
        otherNode.parent.insertBefore(otherNode, this);
        return this;
    };

    /**
     * Removes the node from its current parent and inserts it into
     * a new parent after `otherNode`.
     *
     * This will also clean the node’s code style properties just as it would
     * in {@link Node#moveTo}.
     *
     * @param {Node} otherNode - node that will be after current node
     *
     * @return {Node} current node to methods chain
     */


    Node.prototype.moveAfter = function moveAfter(otherNode) {
        this.cleanRaws(this.root() === otherNode.root());
        this.remove();
        otherNode.parent.insertAfter(otherNode, this);
        return this;
    };

    /**
     * Returns the next child of the node’s parent.
     * Returns `undefined` if the current node is the last child.
     *
     * @return {Node|undefined} next node
     *
     * @example
     * if ( comment.text === 'delete next' ) {
     *   const next = comment.next();
     *   if ( next ) {
     *     next.remove();
     *   }
     * }
     */


    Node.prototype.next = function next() {
        var index = this.parent.index(this);
        return this.parent.nodes[index + 1];
    };

    /**
     * Returns the previous child of the node’s parent.
     * Returns `undefined` if the current node is the first child.
     *
     * @return {Node|undefined} previous node
     *
     * @example
     * const annotation = decl.prev();
     * if ( annotation.type == 'comment' ) {
     *  readAnnotation(annotation.text);
     * }
     */


    Node.prototype.prev = function prev() {
        var index = this.parent.index(this);
        return this.parent.nodes[index - 1];
    };

    Node.prototype.toJSON = function toJSON() {
        var fixed = {};

        for (var name in this) {
            if (!this.hasOwnProperty(name)) continue;
            if (name === 'parent') continue;
            var value = this[name];

            if (value instanceof Array) {
                fixed[name] = value.map(function (i) {
                    if ((typeof i === 'undefined' ? 'undefined' : _typeof(i)) === 'object' && i.toJSON) {
                        return i.toJSON();
                    } else {
                        return i;
                    }
                });
            } else if ((typeof value === 'undefined' ? 'undefined' : _typeof(value)) === 'object' && value.toJSON) {
                fixed[name] = value.toJSON();
            } else {
                fixed[name] = value;
            }
        }

        return fixed;
    };

    /**
     * Returns a {@link Node#raws} value. If the node is missing
     * the code style property (because the node was manually built or cloned),
     * PostCSS will try to autodetect the code style property by looking
     * at other nodes in the tree.
     *
     * @param {string} prop          - name of code style property
     * @param {string} [defaultType] - name of default value, it can be missed
     *                                 if the value is the same as prop
     *
     * @example
     * const root = postcss.parse('a { background: white }');
     * root.nodes[0].append({ prop: 'color', value: 'black' });
     * root.nodes[0].nodes[1].raws.before   //=> undefined
     * root.nodes[0].nodes[1].raw('before') //=> ' '
     *
     * @return {string} code style value
     */


    Node.prototype.raw = function raw(prop, defaultType) {
        var str = new _stringifier2.default();
        return str.raw(this, prop, defaultType);
    };

    /**
     * Finds the Root instance of the node’s tree.
     *
     * @example
     * root.nodes[0].nodes[0].root() === root
     *
     * @return {Root} root parent
     */


    Node.prototype.root = function root() {
        var result = this;
        while (result.parent) {
            result = result.parent;
        }return result;
    };

    Node.prototype.cleanRaws = function cleanRaws(keepBetween) {
        delete this.raws.before;
        delete this.raws.after;
        if (!keepBetween) delete this.raws.between;
    };

    Node.prototype.positionInside = function positionInside(index) {
        var string = this.toString();
        var column = this.source.start.column;
        var line = this.source.start.line;

        for (var i = 0; i < index; i++) {
            if (string[i] === '\n') {
                column = 1;
                line += 1;
            } else {
                column += 1;
            }
        }

        return { line: line, column: column };
    };

    Node.prototype.positionBy = function positionBy(opts) {
        var pos = this.source.start;
        if (opts.index) {
            pos = this.positionInside(opts.index);
        } else if (opts.word) {
            var index = this.toString().indexOf(opts.word);
            if (index !== -1) pos = this.positionInside(index);
        }
        return pos;
    };

    Node.prototype.removeSelf = function removeSelf() {
        (0, _warnOnce2.default)('Node#removeSelf is deprecated. Use Node#remove.');
        return this.remove();
    };

    Node.prototype.replace = function replace(nodes) {
        (0, _warnOnce2.default)('Node#replace is deprecated. Use Node#replaceWith');
        return this.replaceWith(nodes);
    };

    Node.prototype.style = function style(own, detect) {
        (0, _warnOnce2.default)('Node#style() is deprecated. Use Node#raw()');
        return this.raw(own, detect);
    };

    Node.prototype.cleanStyles = function cleanStyles(keepBetween) {
        (0, _warnOnce2.default)('Node#cleanStyles() is deprecated. Use Node#cleanRaws()');
        return this.cleanRaws(keepBetween);
    };

    _createClass(Node, [{
        key: 'before',
        get: function get() {
            (0, _warnOnce2.default)('Node#before is deprecated. Use Node#raws.before');
            return this.raws.before;
        },
        set: function set(val) {
            (0, _warnOnce2.default)('Node#before is deprecated. Use Node#raws.before');
            this.raws.before = val;
        }
    }, {
        key: 'between',
        get: function get() {
            (0, _warnOnce2.default)('Node#between is deprecated. Use Node#raws.between');
            return this.raws.between;
        },
        set: function set(val) {
            (0, _warnOnce2.default)('Node#between is deprecated. Use Node#raws.between');
            this.raws.between = val;
        }

        /**
         * @memberof Node#
         * @member {string} type - String representing the node’s type.
         *                         Possible values are `root`, `atrule`, `rule`,
         *                         `decl`, or `comment`.
         *
         * @example
         * postcss.decl({ prop: 'color', value: 'black' }).type //=> 'decl'
         */

        /**
         * @memberof Node#
         * @member {Container} parent - the node’s parent node.
         *
         * @example
         * root.nodes[0].parent == root;
         */

        /**
         * @memberof Node#
         * @member {source} source - the input source of the node
         *
         * The property is used in source map generation.
         *
         * If you create a node manually (e.g., with `postcss.decl()`),
         * that node will not have a `source` property and will be absent
         * from the source map. For this reason, the plugin developer should
         * consider cloning nodes to create new ones (in which case the new node’s
         * source will reference the original, cloned node) or setting
         * the `source` property manually.
         *
         * ```js
         * // Bad
         * const prefixed = postcss.decl({
         *   prop: '-moz-' + decl.prop,
         *   value: decl.value
         * });
         *
         * // Good
         * const prefixed = decl.clone({ prop: '-moz-' + decl.prop });
         * ```
         *
         * ```js
         * if ( atrule.name == 'add-link' ) {
         *   const rule = postcss.rule({ selector: 'a', source: atrule.source });
         *   atrule.parent.insertBefore(atrule, rule);
         * }
         * ```
         *
         * @example
         * decl.source.input.from //=> '/home/ai/a.sass'
         * decl.source.start      //=> { line: 10, column: 2 }
         * decl.source.end        //=> { line: 10, column: 12 }
         */

        /**
         * @memberof Node#
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
         * * `left`: the space symbols between `/*` and the comment’s text.
         * * `right`: the space symbols between the comment’s text
         *   and <code>*&#47;</code>.
         * * `important`: the content of the important statement,
         *   if it is not just `!important`.
         *
         * PostCSS cleans selectors, declaration values and at-rule parameters
         * from comments and extra spaces, but it stores origin content in raws
         * properties. As such, if you don’t change a declaration’s value,
         * PostCSS will use the raw value with comments.
         *
         * @example
         * const root = postcss.parse('a {\n  color:black\n}')
         * root.first.first.raws //=> { before: '\n  ', between: ':' }
         */

    }]);

    return Node;
}();

exports.default = Node;

/**
 * @typedef {object} position
 * @property {number} line   - source line in file
 * @property {number} column - source column in file
 */

/**
 * @typedef {object} source
 * @property {Input} input    - {@link Input} with input file
 * @property {position} start - The starting position of the node’s source
 * @property {position} end   - The ending position of the node’s source
 */

module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvbm9kZS5lczYiXSwibmFtZXMiOlsiY2xvbmVOb2RlIiwib2JqIiwicGFyZW50IiwiY2xvbmVkIiwiY29uc3RydWN0b3IiLCJpIiwiaGFzT3duUHJvcGVydHkiLCJ2YWx1ZSIsInR5cGUiLCJBcnJheSIsIm1hcCIsImoiLCJOb2RlIiwiZGVmYXVsdHMiLCJyYXdzIiwibmFtZSIsImVycm9yIiwibWVzc2FnZSIsIm9wdHMiLCJzb3VyY2UiLCJwb3MiLCJwb3NpdGlvbkJ5IiwiaW5wdXQiLCJsaW5lIiwiY29sdW1uIiwid2FybiIsInJlc3VsdCIsInRleHQiLCJkYXRhIiwibm9kZSIsInJlbW92ZSIsInJlbW92ZUNoaWxkIiwidW5kZWZpbmVkIiwidG9TdHJpbmciLCJzdHJpbmdpZmllciIsInN0cmluZ2lmeSIsImNsb25lIiwib3ZlcnJpZGVzIiwiY2xvbmVCZWZvcmUiLCJpbnNlcnRCZWZvcmUiLCJjbG9uZUFmdGVyIiwiaW5zZXJ0QWZ0ZXIiLCJyZXBsYWNlV2l0aCIsIm5vZGVzIiwibW92ZVRvIiwibmV3UGFyZW50IiwiY2xlYW5SYXdzIiwicm9vdCIsImFwcGVuZCIsIm1vdmVCZWZvcmUiLCJvdGhlck5vZGUiLCJtb3ZlQWZ0ZXIiLCJuZXh0IiwiaW5kZXgiLCJwcmV2IiwidG9KU09OIiwiZml4ZWQiLCJyYXciLCJwcm9wIiwiZGVmYXVsdFR5cGUiLCJzdHIiLCJrZWVwQmV0d2VlbiIsImJlZm9yZSIsImFmdGVyIiwiYmV0d2VlbiIsInBvc2l0aW9uSW5zaWRlIiwic3RyaW5nIiwic3RhcnQiLCJ3b3JkIiwiaW5kZXhPZiIsInJlbW92ZVNlbGYiLCJyZXBsYWNlIiwic3R5bGUiLCJvd24iLCJkZXRlY3QiLCJjbGVhblN0eWxlcyIsInZhbCJdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7QUFBQTs7OztBQUNBOzs7O0FBQ0E7Ozs7QUFDQTs7Ozs7Ozs7QUFFQSxJQUFJQSxZQUFZLFNBQVpBLFNBQVksQ0FBVUMsR0FBVixFQUFlQyxNQUFmLEVBQXVCO0FB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bnRheEVycm9yIGZyb20gJy4vY3NzLXN5bnRheC1lcnJvcic7XG5pbXBvcnQgU3RyaW5naWZpZXIgICAgZnJvbSAnLi9zdHJpbmdpZmllcic7XG5pbXBvcnQgc3RyaW5naWZ5ICAgICAgZnJvbSAnLi9zdHJpbmdpZnknO1xuaW1wb3J0IHdhcm5PbmNlICAgICAgIGZyb20gJy4vd2Fybi1vbmNlJztcblxubGV0IGNsb25lTm9kZSA9IGZ1bmN0aW9uIChvYmosIHBhcmVudCkge1xuICAgIGxldCBjbG9uZWQgPSBuZXcgb2JqLmNvbnN0cnVjdG9yKCk7XG5cbiAgICBmb3IgKCBsZXQgaSBpbiBvYmogKSB7XG4gICAgICAgIGlmICggIW9iai5oYXNPd25Qcm9wZXJ0eShpKSApIGNvbnRpbnVlO1xuICAgICAgICBsZXQgdmFsdWUgPSBvYmpbaV07XG4gICAgICAgIGxldCB0eXBlICA9IHR5cGVvZiB2YWx1ZTtcblxuICAgICAgICBpZiAoIGkgPT09ICdwYXJlbnQnICYmIHR5cGUgPT09ICdvYmplY3QnICkge1xuICAgICAgICAgICAgaWYgKHBhcmVudCkgY2xvbmVkW2ldID0gcGFyZW50O1xuICAgICAgICB9IGVsc2UgaWYgKCBpID09PSAnc291cmNlJyApIHtcbiAgICAgICAgICAgIGNsb25lZFtpXSA9IHZhbHVlO1xuICAgICAgICB9IGVsc2UgaWYgKCB2YWx1ZSBpbnN0YW5jZW9mIEFycmF5ICkge1xuICAgICAgICAgICAgY2xvbmVkW2ldID0gdmFsdWUubWFwKCBqID0+IGNsb25lTm9kZShqLCBjbG9uZWQpICk7XG4gICAgICAgIH0gZWxzZSBpZiAoIGkgIT09ICdiZWZvcmUnICAmJiBpICE9PSAnYWZ0ZXInICYmXG4gICAgICAgICAgICAgICAgICAgIGkgIT09ICdiZXR3ZWVuJyAmJiBpICE9PSAnc2VtaWNvbG9uJyApIHtcbiAgICAgICAgICAgIGlmICggdHlwZSA9PT0gJ29iamVjdCcgJiYgdmFsdWUgIT09IG51bGwgKSB2YWx1ZSA9IGNsb25lTm9kZSh2YWx1ZSk7XG4gICAgICAgICAgICBjbG9uZWRbaV0gPSB2YWx1ZTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIHJldHVybiBjbG9uZWQ7XG59O1xuXG4vKipcbiAqIEFsbCBub2RlIGNsYXNzZXMgaW5oZXJpdCB0aGUgZm9sbG93aW5nIGNvbW1vbiBtZXRob2RzLlxuICpcbiAqIEBhYnN0cmFjdFxuICovXG5jbGFzcyBOb2RlIHtcblxuICAgIC8qKlxuICAgICAqIEBwYXJhbSB7b2JqZWN0fSBbZGVmYXVsdHNdIC0gdmFsdWUgZm9yIG5vZGUgcHJvcGVydGllc1xuICAgICAqL1xuICAgIGNvbnN0cnVjdG9yKGRlZmF1bHRzID0geyB9KSB7XG4gICAgICAgIHRoaXMucmF3cyA9IHsgfTtcbiAgICAgICAgZm9yICggbGV0IG5hbWUgaW4gZGVmYXVsdHMgKSB7XG4gICAgICAgICAgICB0aGlzW25hbWVdID0gZGVmYXVsdHNbbmFtZV07XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIGEgQ3NzU3ludGF4RXJyb3IgaW5zdGFuY2UgY29udGFpbmluZyB0aGUgb3JpZ2luYWwgcG9zaXRpb25cbiAgICAgKiBvZiB0aGUgbm9kZSBpbiB0aGUgc291cmNlLCBzaG93aW5nIGxpbmUgYW5kIGNvbHVtbiBudW1iZXJzIGFuZCBhbHNvXG4gICAgICogYSBzbWFsbCBleGNlcnB0IHRvIGZhY2lsaXRhdGUgZGVidWdnaW5nLlxuICAgICAqXG4gICAgICogSWYgcHJlc2VudCwgYW4gaW5wdXQgc291cmNlIG1hcCB3aWxsIGJlIHVzZWQgdG8gZ2V0IHRoZSBvcmlnaW5hbCBwb3NpdGlvblxuICAgICAqIG9mIHRoZSBzb3VyY2UsIGV2ZW4gZnJvbSBhIHByZXZpb3VzIGNvbXBpbGF0aW9uIHN0ZXBcbiAgICAgKiAoZS5nLiwgZnJvbSBTYXNzIGNvbXBpbGF0aW9uKS5cbiAgICAgKlxuICAgICAqIFRoaXMgbWV0aG9kIHByb2R1Y2VzIHZlcnkgdXNlZnVsIGVycm9yIG1lc3NhZ2VzLlxuICAgICAqXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IG1lc3NhZ2UgICAgIC0gZXJyb3IgZGVzY3JpcHRpb25cbiAgICAgKiBAcGFyYW0ge29iamVjdH0gW29wdHNdICAgICAgLSBvcHRpb25zXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IG9wdHMucGx1Z2luIC0gcGx1Z2luIG5hbWUgdGhhdCBjcmVhdGVkIHRoaXMgZXJyb3IuXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUG9zdENTUyB3aWxsIHNldCBpdCBhdXRvbWF0aWNhbGx5LlxuICAgICAqIEBwYXJhbSB7c3RyaW5nfSBvcHRzLndvcmQgICAtIGEgd29yZCBpbnNpZGUgYSBub2Rl4oCZcyBzdHJpbmcgdGhhdCBzaG91bGRcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiZSBoaWdobGlnaHRlZCBhcyB0aGUgc291cmNlIG9mIHRoZSBlcnJvclxuICAgICAqIEBwYXJhbSB7bnVtYmVyfSBvcHRzLmluZGV4ICAtIGFuIGluZGV4IGluc2lkZSBhIG5vZGXigJlzIHN0cmluZyB0aGF0IHNob3VsZFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJlIGhpZ2hsaWdodGVkIGFzIHRoZSBzb3VyY2Ugb2YgdGhlIGVycm9yXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtDc3NTeW50YXhFcnJvcn0gZXJyb3Igb2JqZWN0IHRvIHRocm93IGl0XG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGlmICggIXZhcmlhYmxlc1tuYW1lXSApIHtcbiAgICAgKiAgIHRocm93IGRlY2wuZXJyb3IoJ1Vua25vd24gdmFyaWFibGUgJyArIG5hbWUsIHsgd29yZDogbmFtZSB9KTtcbiAgICAgKiAgIC8vIENzc1N5bnRheEVycm9yOiBwb3N0Y3NzLXZhcnM6YS5zYXNzOjQ6MzogVW5rbm93biB2YXJpYWJsZSAkYmxhY2tcbiAgICAgKiAgIC8vICAgY29sb3I6ICRibGFja1xuICAgICAqICAgLy8gYVxuICAgICAqICAgLy8gICAgICAgICAgXlxuICAgICAqICAgLy8gICBiYWNrZ3JvdW5kOiB3aGl0ZVxuICAgICAqIH1cbiAgICAgKi9cbiAgICBlcnJvcihtZXNzYWdlLCBvcHRzID0geyB9KSB7XG4gICAgICAgIGlmICggdGhpcy5zb3VyY2UgKSB7XG4gICAgICAgICAgICBsZXQgcG9zID0gdGhpcy5wb3NpdGlvbkJ5KG9wdHMpO1xuICAgICAgICAgICAgcmV0dXJuIHRoaXMuc291cmNlLmlucHV0LmVycm9yKG1lc3NhZ2UsIHBvcy5saW5lLCBwb3MuY29sdW1uLCBvcHRzKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiBuZXcgQ3NzU3ludGF4RXJyb3IobWVzc2FnZSk7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBUaGlzIG1ldGhvZCBpcyBwcm92aWRlZCBhcyBhIGNvbnZlbmllbmNlIHdyYXBwZXIgZm9yIHtAbGluayBSZXN1bHQjd2Fybn0uXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge1Jlc3VsdH0gcmVzdWx0ICAgICAgLSB0aGUge0BsaW5rIFJlc3VsdH0gaW5zdGFuY2VcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aGF0IHdpbGwgcmVjZWl2ZSB0aGUgd2FybmluZ1xuICAgICAqIEBwYXJhbSB7c3RyaW5nfSB0ZXh0ICAgICAgICAtIHdhcm5pbmcgbWVzc2FnZVxuICAgICAqIEBwYXJhbSB7b2JqZWN0fSBbb3B0c10gICAgICAtIG9wdGlvbnNcbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gb3B0cy5wbHVnaW4gLSBwbHVnaW4gbmFtZSB0aGF0IGNyZWF0ZWQgdGhpcyB3YXJuaW5nLlxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBvc3RDU1Mgd2lsbCBzZXQgaXQgYXV0b21hdGljYWxseS5cbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gb3B0cy53b3JkICAgLSBhIHdvcmQgaW5zaWRlIGEgbm9kZeKAmXMgc3RyaW5nIHRoYXQgc2hvdWxkXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmUgaGlnaGxpZ2h0ZWQgYXMgdGhlIHNvdXJjZSBvZiB0aGUgd2FybmluZ1xuICAgICAqIEBwYXJhbSB7bnVtYmVyfSBvcHRzLmluZGV4ICAtIGFuIGluZGV4IGluc2lkZSBhIG5vZGXigJlzIHN0cmluZyB0aGF0IHNob3VsZFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJlIGhpZ2hsaWdodGVkIGFzIHRoZSBzb3VyY2Ugb2YgdGhlIHdhcm5pbmdcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge1dhcm5pbmd9IGNyZWF0ZWQgd2FybmluZyBvYmplY3RcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogY29uc3QgcGx1Z2luID0gcG9zdGNzcy5wbHVnaW4oJ3Bvc3Rjc3MtZGVwcmVjYXRlZCcsICgpID0+IHtcbiAgICAgKiAgIHJldHVybiAocm9vdCwgcmVzdWx0KSA9PiB7XG4gICAgICogICAgIHJvb3Qud2Fsa0RlY2xzKCdiYWQnLCBkZWNsID0+IHtcbiAgICAgKiAgICAgICBkZWNsLndhcm4ocmVzdWx0LCAnRGVwcmVjYXRlZCBwcm9wZXJ0eSBiYWQnKTtcbiAgICAgKiAgICAgfSk7XG4gICAgICogICB9O1xuICAgICAqIH0pO1xuICAgICAqL1xuICAgIHdhcm4ocmVzdWx0LCB0ZXh0LCBvcHRzKSB7XG4gICAgICAgIGxldCBkYXRhID0geyBub2RlOiB0aGlzIH07XG4gICAgICAgIGZvciAoIGxldCBpIGluIG9wdHMgKSBkYXRhW2ldID0gb3B0c1tpXTtcbiAgICAgICAgcmV0dXJuIHJlc3VsdC53YXJuKHRleHQsIGRhdGEpO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIFJlbW92ZXMgdGhlIG5vZGUgZnJvbSBpdHMgcGFyZW50IGFuZCBjbGVhbnMgdGhlIHBhcmVudCBwcm9wZXJ0aWVzXG4gICAgICogZnJvbSB0aGUgbm9kZSBhbmQgaXRzIGNoaWxkcmVuLlxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBpZiAoIGRlY2wucHJvcC5tYXRjaCgvXi13ZWJraXQtLykgKSB7XG4gICAgICogICBkZWNsLnJlbW92ZSgpO1xuICAgICAqIH1cbiAgICAgKlxuICAgICAqIEByZXR1cm4ge05vZGV9IG5vZGUgdG8gbWFrZSBjYWxscyBjaGFpblxuICAgICAqL1xuICAgIHJlbW92ZSgpIHtcbiAgICAgICAgaWYgKCB0aGlzLnBhcmVudCApIHtcbiAgICAgICAgICAgIHRoaXMucGFyZW50LnJlbW92ZUNoaWxkKHRoaXMpO1xuICAgICAgICB9XG4gICAgICAgIHRoaXMucGFyZW50ID0gdW5kZWZpbmVkO1xuICAgICAgICByZXR1cm4gdGhpcztcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIGEgQ1NTIHN0cmluZyByZXByZXNlbnRpbmcgdGhlIG5vZGUuXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge3N0cmluZ2lmaWVyfHN5bnRheH0gW3N0cmluZ2lmaWVyXSAtIGEgc3ludGF4IHRvIHVzZVxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW4gc3RyaW5nIGdlbmVyYXRpb25cbiAgICAgKlxuICAgICAqIEByZXR1cm4ge3N0cmluZ30gQ1NTIHN0cmluZyBvZiB0aGlzIG5vZGVcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcG9zdGNzcy5ydWxlKHsgc2VsZWN0b3I6ICdhJyB9KS50b1N0cmluZygpIC8vPT4gXCJhIHt9XCJcbiAgICAgKi9cbiAgICB0b1N0cmluZyhzdHJpbmdpZmllciA9IHN0cmluZ2lmeSkge1xuICAgICAgICBpZiAoIHN0cmluZ2lmaWVyLnN0cmluZ2lmeSApIHN0cmluZ2lmaWVyID0gc3RyaW5naWZpZXIuc3RyaW5naWZ5O1xuICAgICAgICBsZXQgcmVzdWx0ICA9ICcnO1xuICAgICAgICBzdHJpbmdpZmllcih0aGlzLCBpID0+IHtcbiAgICAgICAgICAgIHJlc3VsdCArPSBpO1xuICAgICAgICB9KTtcbiAgICAgICAgcmV0dXJuIHJlc3VsdDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIGEgY2xvbmUgb2YgdGhlIG5vZGUuXG4gICAgICpcbiAgICAgKiBUaGUgcmVzdWx0aW5nIGNsb25lZCBub2RlIGFuZCBpdHMgKGNsb25lZCkgY2hpbGRyZW4gd2lsbCBoYXZlXG4gICAgICogYSBjbGVhbiBwYXJlbnQgYW5kIGNvZGUgc3R5bGUgcHJvcGVydGllcy5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7b2JqZWN0fSBbb3ZlcnJpZGVzXSAtIG5ldyBwcm9wZXJ0aWVzIHRvIG92ZXJyaWRlIGluIHRoZSBjbG9uZS5cbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogY29uc3QgY2xvbmVkID0gZGVjbC5jbG9uZSh7IHByb3A6ICctbW96LScgKyBkZWNsLnByb3AgfSk7XG4gICAgICogY2xvbmVkLnJhd3MuYmVmb3JlICAvLz0+IHVuZGVmaW5lZFxuICAgICAqIGNsb25lZC5wYXJlbnQgICAgICAgLy89PiB1bmRlZmluZWRcbiAgICAgKiBjbG9uZWQudG9TdHJpbmcoKSAgIC8vPT4gLW1vei10cmFuc2Zvcm06IHNjYWxlKDApXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtOb2RlfSBjbG9uZSBvZiB0aGUgbm9kZVxuICAgICAqL1xuICAgIGNsb25lKG92ZXJyaWRlcyA9IHsgfSkge1xuICAgICAgICBsZXQgY2xvbmVkID0gY2xvbmVOb2RlKHRoaXMpO1xuICAgICAgICBmb3IgKCBsZXQgbmFtZSBpbiBvdmVycmlkZXMgKSB7XG4gICAgICAgICAgICBjbG9uZWRbbmFtZV0gPSBvdmVycmlkZXNbbmFtZV07XG4gICAgICAgIH1cbiAgICAgICAgcmV0dXJuIGNsb25lZDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBTaG9ydGN1dCB0byBjbG9uZSB0aGUgbm9kZSBhbmQgaW5zZXJ0IHRoZSByZXN1bHRpbmcgY2xvbmVkIG5vZGVcbiAgICAgKiBiZWZvcmUgdGhlIGN1cnJlbnQgbm9kZS5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7b2JqZWN0fSBbb3ZlcnJpZGVzXSAtIG5ldyBwcm9wZXJ0aWVzIHRvIG92ZXJyaWRlIGluIHRoZSBjbG9uZS5cbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogZGVjbC5jbG9uZUJlZm9yZSh7IHByb3A6ICctbW96LScgKyBkZWNsLnByb3AgfSk7XG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtOb2RlfSAtIG5ldyBub2RlXG4gICAgICovXG4gICAgY2xvbmVCZWZvcmUob3ZlcnJpZGVzID0geyB9KSB7XG4gICAgICAgIGxldCBjbG9uZWQgPSB0aGlzLmNsb25lKG92ZXJyaWRlcyk7XG4gICAgICAgIHRoaXMucGFyZW50Lmluc2VydEJlZm9yZSh0aGlzLCBjbG9uZWQpO1xuICAgICAgICByZXR1cm4gY2xvbmVkO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIFNob3J0Y3V0IHRvIGNsb25lIHRoZSBub2RlIGFuZCBpbnNlcnQgdGhlIHJlc3VsdGluZyBjbG9uZWQgbm9kZVxuICAgICAqIGFmdGVyIHRoZSBjdXJyZW50IG5vZGUuXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge29iamVjdH0gW292ZXJyaWRlc10gLSBuZXcgcHJvcGVydGllcyB0byBvdmVycmlkZSBpbiB0aGUgY2xvbmUuXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtOb2RlfSAtIG5ldyBub2RlXG4gICAgICovXG4gICAgY2xvbmVBZnRlcihvdmVycmlkZXMgPSB7IH0pIHtcbiAgICAgICAgbGV0IGNsb25lZCA9IHRoaXMuY2xvbmUob3ZlcnJpZGVzKTtcbiAgICAgICAgdGhpcy5wYXJlbnQuaW5zZXJ0QWZ0ZXIodGhpcywgY2xvbmVkKTtcbiAgICAgICAgcmV0dXJuIGNsb25lZDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBJbnNlcnRzIG5vZGUocykgYmVmb3JlIHRoZSBjdXJyZW50IG5vZGUgYW5kIHJlbW92ZXMgdGhlIGN1cnJlbnQgbm9kZS5cbiAgICAgKlxuICAgICAqIEBwYXJhbSB7Li4uTm9kZX0gbm9kZXMgLSBub2RlKHMpIHRvIHJlcGxhY2UgY3VycmVudCBvbmVcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogaWYgKCBhdHJ1bGUubmFtZSA9PSAnbWl4aW4nICkge1xuICAgICAqICAgYXRydWxlLnJlcGxhY2VXaXRoKG1peGluUnVsZXNbYXRydWxlLnBhcmFtc10pO1xuICAgICAqIH1cbiAgICAgKlxuICAgICAqIEByZXR1cm4ge05vZGV9IGN1cnJlbnQgbm9kZSB0byBtZXRob2RzIGNoYWluXG4gICAgICovXG4gICAgcmVwbGFjZVdpdGgoLi4ubm9kZXMpIHtcbiAgICAgICAgaWYgKHRoaXMucGFyZW50KSB7XG4gICAgICAgICAgICBmb3IgKGxldCBub2RlIG9mIG5vZGVzKSB7XG4gICAgICAgICAgICAgICAgdGhpcy5wYXJlbnQuaW5zZXJ0QmVmb3JlKHRoaXMsIG5vZGUpO1xuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICB0aGlzLnJlbW92ZSgpO1xuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIHRoaXM7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUmVtb3ZlcyB0aGUgbm9kZSBmcm9tIGl0cyBjdXJyZW50IHBhcmVudCBhbmQgaW5zZXJ0cyBpdFxuICAgICAqIGF0IHRoZSBlbmQgb2YgYG5ld1BhcmVudGAuXG4gICAgICpcbiAgICAgKiBUaGlzIHdpbGwgY2xlYW4gdGhlIGBiZWZvcmVgIGFuZCBgYWZ0ZXJgIGNvZGUge0BsaW5rIE5vZGUjcmF3c30gZGF0YVxuICAgICAqIGZyb20gdGhlIG5vZGUgYW5kIHJlcGxhY2UgdGhlbSB3aXRoIHRoZSBpbmRlbnRhdGlvbiBzdHlsZSBvZiBgbmV3UGFyZW50YC5cbiAgICAgKiBJdCB3aWxsIGFsc28gY2xlYW4gdGhlIGBiZXR3ZWVuYCBwcm9wZXJ0eVxuICAgICAqIGlmIGBuZXdQYXJlbnRgIGlzIGluIGFub3RoZXIge0BsaW5rIFJvb3R9LlxuICAgICAqXG4gICAgICogQHBhcmFtIHtDb250YWluZXJ9IG5ld1BhcmVudCAtIGNvbnRhaW5lciBub2RlIHdoZXJlIHRoZSBjdXJyZW50IG5vZGVcbiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2lsbCBiZSBtb3ZlZFxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBhdHJ1bGUubW92ZVRvKGF0cnVsZS5yb290KCkpO1xuICAgICAqXG4gICAgICogQHJldHVybiB7Tm9kZX0gY3VycmVudCBub2RlIHRvIG1ldGhvZHMgY2hhaW5cbiAgICAgKi9cbiAgICBtb3ZlVG8obmV3UGFyZW50KSB7XG4gICAgICAgIHRoaXMuY2xlYW5SYXdzKHRoaXMucm9vdCgpID09PSBuZXdQYXJlbnQucm9vdCgpKTtcbiAgICAgICAgdGhpcy5yZW1vdmUoKTtcbiAgICAgICAgbmV3UGFyZW50LmFwcGVuZCh0aGlzKTtcbiAgICAgICAgcmV0dXJuIHRoaXM7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUmVtb3ZlcyB0aGUgbm9kZSBmcm9tIGl0cyBjdXJyZW50IHBhcmVudCBhbmQgaW5zZXJ0cyBpdCBpbnRvXG4gICAgICogYSBuZXcgcGFyZW50IGJlZm9yZSBgb3RoZXJOb2RlYC5cbiAgICAgKlxuICAgICAqIFRoaXMgd2lsbCBhbHNvIGNsZWFuIHRoZSBub2Rl4oCZcyBjb2RlIHN0eWxlIHByb3BlcnRpZXMganVzdCBhcyBpdCB3b3VsZFxuICAgICAqIGluIHtAbGluayBOb2RlI21vdmVUb30uXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge05vZGV9IG90aGVyTm9kZSAtIG5vZGUgdGhhdCB3aWxsIGJlIGJlZm9yZSBjdXJyZW50IG5vZGVcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge05vZGV9IGN1cnJlbnQgbm9kZSB0byBtZXRob2RzIGNoYWluXG4gICAgICovXG4gICAgbW92ZUJlZm9yZShvdGhlck5vZGUpIHtcbiAgICAgICAgdGhpcy5jbGVhblJhd3ModGhpcy5yb290KCkgPT09IG90aGVyTm9kZS5yb290KCkpO1xuICAgICAgICB0aGlzLnJlbW92ZSgpO1xuICAgICAgICBvdGhlck5vZGUucGFyZW50Lmluc2VydEJlZm9yZShvdGhlck5vZGUsIHRoaXMpO1xuICAgICAgICByZXR1cm4gdGhpcztcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZW1vdmVzIHRoZSBub2RlIGZyb20gaXRzIGN1cnJlbnQgcGFyZW50IGFuZCBpbnNlcnRzIGl0IGludG9cbiAgICAgKiBhIG5ldyBwYXJlbnQgYWZ0ZXIgYG90aGVyTm9kZWAuXG4gICAgICpcbiAgICAgKiBUaGlzIHdpbGwgYWxzbyBjbGVhbiB0aGUgbm9kZeKAmXMgY29kZSBzdHlsZSBwcm9wZXJ0aWVzIGp1c3QgYXMgaXQgd291bGRcbiAgICAgKiBpbiB7QGxpbmsgTm9kZSNtb3ZlVG99LlxuICAgICAqXG4gICAgICogQHBhcmFtIHtOb2RlfSBvdGhlck5vZGUgLSBub2RlIHRoYXQgd2lsbCBiZSBhZnRlciBjdXJyZW50IG5vZGVcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge05vZGV9IGN1cnJlbnQgbm9kZSB0byBtZXRob2RzIGNoYWluXG4gICAgICovXG4gICAgbW92ZUFmdGVyKG90aGVyTm9kZSkge1xuICAgICAgICB0aGlzLmNsZWFuUmF3cyh0aGlzLnJvb3QoKSA9PT0gb3RoZXJOb2RlLnJvb3QoKSk7XG4gICAgICAgIHRoaXMucmVtb3ZlKCk7XG4gICAgICAgIG90aGVyTm9kZS5wYXJlbnQuaW5zZXJ0QWZ0ZXIob3RoZXJOb2RlLCB0aGlzKTtcbiAgICAgICAgcmV0dXJuIHRoaXM7XG4gICAgfVxuXG4gICAgLyoqXG4gICAgICogUmV0dXJucyB0aGUgbmV4dCBjaGlsZCBvZiB0aGUgbm9kZeKAmXMgcGFyZW50LlxuICAgICAqIFJldHVybnMgYHVuZGVmaW5lZGAgaWYgdGhlIGN1cnJlbnQgbm9kZSBpcyB0aGUgbGFzdCBjaGlsZC5cbiAgICAgKlxuICAgICAqIEByZXR1cm4ge05vZGV8dW5kZWZpbmVkfSBuZXh0IG5vZGVcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogaWYgKCBjb21tZW50LnRleHQgPT09ICdkZWxldGUgbmV4dCcgKSB7XG4gICAgICogICBjb25zdCBuZXh0ID0gY29tbWVudC5uZXh0KCk7XG4gICAgICogICBpZiAoIG5leHQgKSB7XG4gICAgICogICAgIG5leHQucmVtb3ZlKCk7XG4gICAgICogICB9XG4gICAgICogfVxuICAgICAqL1xuICAgIG5leHQoKSB7XG4gICAgICAgIGxldCBpbmRleCA9IHRoaXMucGFyZW50LmluZGV4KHRoaXMpO1xuICAgICAgICByZXR1cm4gdGhpcy5wYXJlbnQubm9kZXNbaW5kZXggKyAxXTtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIHRoZSBwcmV2aW91cyBjaGlsZCBvZiB0aGUgbm9kZeKAmXMgcGFyZW50LlxuICAgICAqIFJldHVybnMgYHVuZGVmaW5lZGAgaWYgdGhlIGN1cnJlbnQgbm9kZSBpcyB0aGUgZmlyc3QgY2hpbGQuXG4gICAgICpcbiAgICAgKiBAcmV0dXJuIHtOb2RlfHVuZGVmaW5lZH0gcHJldmlvdXMgbm9kZVxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBjb25zdCBhbm5vdGF0aW9uID0gZGVjbC5wcmV2KCk7XG4gICAgICogaWYgKCBhbm5vdGF0aW9uLnR5cGUgPT0gJ2NvbW1lbnQnICkge1xuICAgICAqICByZWFkQW5ub3RhdGlvbihhbm5vdGF0aW9uLnRleHQpO1xuICAgICAqIH1cbiAgICAgKi9cbiAgICBwcmV2KCkge1xuICAgICAgICBsZXQgaW5kZXggPSB0aGlzLnBhcmVudC5pbmRleCh0aGlzKTtcbiAgICAgICAgcmV0dXJuIHRoaXMucGFyZW50Lm5vZGVzW2luZGV4IC0gMV07XG4gICAgfVxuXG4gICAgdG9KU09OKCkge1xuICAgICAgICBsZXQgZml4ZWQgPSB7IH07XG5cbiAgICAgICAgZm9yICggbGV0IG5hbWUgaW4gdGhpcyApIHtcbiAgICAgICAgICAgIGlmICggIXRoaXMuaGFzT3duUHJvcGVydHkobmFtZSkgKSBjb250aW51ZTtcbiAgICAgICAgICAgIGlmICggbmFtZSA9PT0gJ3BhcmVudCcgKSBjb250aW51ZTtcbiAgICAgICAgICAgIGxldCB2YWx1ZSA9IHRoaXNbbmFtZV07XG5cbiAgICAgICAgICAgIGlmICggdmFsdWUgaW5zdGFuY2VvZiBBcnJheSApIHtcbiAgICAgICAgICAgICAgICBmaXhlZFtuYW1lXSA9IHZhbHVlLm1hcCggaSA9PiB7XG4gICAgICAgICAgICAgICAgICAgIGlmICggdHlwZW9mIGkgPT09ICdvYmplY3QnICYmIGkudG9KU09OICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGkudG9KU09OKCk7XG4gICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gaTtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH0pO1xuICAgICAgICAgICAgfSBlbHNlIGlmICggdHlwZW9mIHZhbHVlID09PSAnb2JqZWN0JyAmJiB2YWx1ZS50b0pTT04gKSB7XG4gICAgICAgICAgICAgICAgZml4ZWRbbmFtZV0gPSB2YWx1ZS50b0pTT04oKTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgZml4ZWRbbmFtZV0gPSB2YWx1ZTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuXG4gICAgICAgIHJldHVybiBmaXhlZDtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBSZXR1cm5zIGEge0BsaW5rIE5vZGUjcmF3c30gdmFsdWUuIElmIHRoZSBub2RlIGlzIG1pc3NpbmdcbiAgICAgKiB0aGUgY29kZSBzdHlsZSBwcm9wZXJ0eSAoYmVjYXVzZSB0aGUgbm9kZSB3YXMgbWFudWFsbHkgYnVpbHQgb3IgY2xvbmVkKSxcbiAgICAgKiBQb3N0Q1NTIHdpbGwgdHJ5IHRvIGF1dG9kZXRlY3QgdGhlIGNvZGUgc3R5bGUgcHJvcGVydHkgYnkgbG9va2luZ1xuICAgICAqIGF0IG90aGVyIG5vZGVzIGluIHRoZSB0cmVlLlxuICAgICAqXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IHByb3AgICAgICAgICAgLSBuYW1lIG9mIGNvZGUgc3R5bGUgcHJvcGVydHlcbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gW2RlZmF1bHRUeXBlXSAtIG5hbWUgb2YgZGVmYXVsdCB2YWx1ZSwgaXQgY2FuIGJlIG1pc3NlZFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgdGhlIHZhbHVlIGlzIHRoZSBzYW1lIGFzIHByb3BcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogY29uc3Qgcm9vdCA9IHBvc3Rjc3MucGFyc2UoJ2EgeyBiYWNrZ3JvdW5kOiB3aGl0ZSB9Jyk7XG4gICAgICogcm9vdC5ub2Rlc1swXS5hcHBlbmQoeyBwcm9wOiAnY29sb3InLCB2YWx1ZTogJ2JsYWNrJyB9KTtcbiAgICAgKiByb290Lm5vZGVzWzBdLm5vZGVzWzFdLnJhd3MuYmVmb3JlICAgLy89PiB1bmRlZmluZWRcbiAgICAgKiByb290Lm5vZGVzWzBdLm5vZGVzWzFdLnJhdygnYmVmb3JlJykgLy89PiAnICdcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge3N0cmluZ30gY29kZSBzdHlsZSB2YWx1ZVxuICAgICAqL1xuICAgIHJhdyhwcm9wLCBkZWZhdWx0VHlwZSkge1xuICAgICAgICBsZXQgc3RyID0gbmV3IFN0cmluZ2lmaWVyKCk7XG4gICAgICAgIHJldHVybiBzdHIucmF3KHRoaXMsIHByb3AsIGRlZmF1bHRUeXBlKTtcbiAgICB9XG5cbiAgICAvKipcbiAgICAgKiBGaW5kcyB0aGUgUm9vdCBpbnN0YW5jZSBvZiB0aGUgbm9kZeKAmXMgdHJlZS5cbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcm9vdC5ub2Rlc1swXS5ub2Rlc1swXS5yb290KCkgPT09IHJvb3RcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge1Jvb3R9IHJvb3QgcGFyZW50XG4gICAgICovXG4gICAgcm9vdCgpIHtcbiAgICAgICAgbGV0IHJlc3VsdCA9IHRoaXM7XG4gICAgICAgIHdoaWxlICggcmVzdWx0LnBhcmVudCApIHJlc3VsdCA9IHJlc3VsdC5wYXJlbnQ7XG4gICAgICAgIHJldHVybiByZXN1bHQ7XG4gICAgfVxuXG4gICAgY2xlYW5SYXdzKGtlZXBCZXR3ZWVuKSB7XG4gICAgICAgIGRlbGV0ZSB0aGlzLnJhd3MuYmVmb3JlO1xuICAgICAgICBkZWxldGUgdGhpcy5yYXdzLmFmdGVyO1xuICAgICAgICBpZiAoICFrZWVwQmV0d2VlbiApIGRlbGV0ZSB0aGlzLnJhd3MuYmV0d2VlbjtcbiAgICB9XG5cbiAgICBwb3NpdGlvbkluc2lkZShpbmRleCkge1xuICAgICAgICBsZXQgc3RyaW5nID0gdGhpcy50b1N0cmluZygpO1xuICAgICAgICBsZXQgY29sdW1uID0gdGhpcy5zb3VyY2Uuc3RhcnQuY29sdW1uO1xuICAgICAgICBsZXQgbGluZSAgID0gdGhpcy5zb3VyY2Uuc3RhcnQubGluZTtcblxuICAgICAgICBmb3IgKCBsZXQgaSA9IDA7IGkgPCBpbmRleDsgaSsrICkge1xuICAgICAgICAgICAgaWYgKCBzdHJpbmdbaV0gPT09ICdcXG4nICkge1xuICAgICAgICAgICAgICAgIGNvbHVtbiA9IDE7XG4gICAgICAgICAgICAgICAgbGluZSAgKz0gMTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgY29sdW1uICs9IDE7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cblxuICAgICAgICByZXR1cm4geyBsaW5lLCBjb2x1bW4gfTtcbiAgICB9XG5cbiAgICBwb3NpdGlvbkJ5KG9wdHMpIHtcbiAgICAgICAgbGV0IHBvcyA9IHRoaXMuc291cmNlLnN0YXJ0O1xuICAgICAgICBpZiAoIG9wdHMuaW5kZXggKSB7XG4gICAgICAgICAgICBwb3MgPSB0aGlzLnBvc2l0aW9uSW5zaWRlKG9wdHMuaW5kZXgpO1xuICAgICAgICB9IGVsc2UgaWYgKCBvcHRzLndvcmQgKSB7XG4gICAgICAgICAgICBsZXQgaW5kZXggPSB0aGlzLnRvU3RyaW5nKCkuaW5kZXhPZihvcHRzLndvcmQpO1xuICAgICAgICAgICAgaWYgKCBpbmRleCAhPT0gLTEgKSBwb3MgPSB0aGlzLnBvc2l0aW9uSW5zaWRlKGluZGV4KTtcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gcG9zO1xuICAgIH1cblxuICAgIHJlbW92ZVNlbGYoKSB7XG4gICAgICAgIHdhcm5PbmNlKCdOb2RlI3JlbW92ZVNlbGYgaXMgZGVwcmVjYXRlZC4gVXNlIE5vZGUjcmVtb3ZlLicpO1xuICAgICAgICByZXR1cm4gdGhpcy5yZW1vdmUoKTtcbiAgICB9XG5cbiAgICByZXBsYWNlKG5vZGVzKSB7XG4gICAgICAgIHdhcm5PbmNlKCdOb2RlI3JlcGxhY2UgaXMgZGVwcmVjYXRlZC4gVXNlIE5vZGUjcmVwbGFjZVdpdGgnKTtcbiAgICAgICAgcmV0dXJuIHRoaXMucmVwbGFjZVdpdGgobm9kZXMpO1xuICAgIH1cblxuICAgIHN0eWxlKG93biwgZGV0ZWN0KSB7XG4gICAgICAgIHdhcm5PbmNlKCdOb2RlI3N0eWxlKCkgaXMgZGVwcmVjYXRlZC4gVXNlIE5vZGUjcmF3KCknKTtcbiAgICAgICAgcmV0dXJuIHRoaXMucmF3KG93biwgZGV0ZWN0KTtcbiAgICB9XG5cbiAgICBjbGVhblN0eWxlcyhrZWVwQmV0d2Vlbikge1xuICAgICAgICB3YXJuT25jZSgnTm9kZSNjbGVhblN0eWxlcygpIGlzIGRlcHJlY2F0ZWQuIFVzZSBOb2RlI2NsZWFuUmF3cygpJyk7XG4gICAgICAgIHJldHVybiB0aGlzLmNsZWFuUmF3cyhrZWVwQmV0d2Vlbik7XG4gICAgfVxuXG4gICAgZ2V0IGJlZm9yZSgpIHtcbiAgICAgICAgd2Fybk9uY2UoJ05vZGUjYmVmb3JlIGlzIGRlcHJlY2F0ZWQuIFVzZSBOb2RlI3Jhd3MuYmVmb3JlJyk7XG4gICAgICAgIHJldHVybiB0aGlzLnJhd3MuYmVmb3JlO1xuICAgIH1cblxuICAgIHNldCBiZWZvcmUodmFsKSB7XG4gICAgICAgIHdhcm5PbmNlKCdOb2RlI2JlZm9yZSBpcyBkZXByZWNhdGVkLiBVc2UgTm9kZSNyYXdzLmJlZm9yZScpO1xuICAgICAgICB0aGlzLnJhd3MuYmVmb3JlID0gdmFsO1xuICAgIH1cblxuICAgIGdldCBiZXR3ZWVuKCkge1xuICAgICAgICB3YXJuT25jZSgnTm9kZSNiZXR3ZWVuIGlzIGRlcHJlY2F0ZWQuIFVzZSBOb2RlI3Jhd3MuYmV0d2VlbicpO1xuICAgICAgICByZXR1cm4gdGhpcy5yYXdzLmJldHdlZW47XG4gICAgfVxuXG4gICAgc2V0IGJldHdlZW4odmFsKSB7XG4gICAgICAgIHdhcm5PbmNlKCdOb2RlI2JldHdlZW4gaXMgZGVwcmVjYXRlZC4gVXNlIE5vZGUjcmF3cy5iZXR3ZWVuJyk7XG4gICAgICAgIHRoaXMucmF3cy5iZXR3ZWVuID0gdmFsO1xuICAgIH1cblxuICAgIC8qKlxuICAgICAqIEBtZW1iZXJvZiBOb2RlI1xuICAgICAqIEBtZW1iZXIge3N0cmluZ30gdHlwZSAtIFN0cmluZyByZXByZXNlbnRpbmcgdGhlIG5vZGXigJlzIHR5cGUuXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgUG9zc2libGUgdmFsdWVzIGFyZSBgcm9vdGAsIGBhdHJ1bGVgLCBgcnVsZWAsXG4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgYGRlY2xgLCBvciBgY29tbWVudGAuXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIHBvc3Rjc3MuZGVjbCh7IHByb3A6ICdjb2xvcicsIHZhbHVlOiAnYmxhY2snIH0pLnR5cGUgLy89PiAnZGVjbCdcbiAgICAgKi9cblxuICAgIC8qKlxuICAgICAqIEBtZW1iZXJvZiBOb2RlI1xuICAgICAqIEBtZW1iZXIge0NvbnRhaW5lcn0gcGFyZW50IC0gdGhlIG5vZGXigJlzIHBhcmVudCBub2RlLlxuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiByb290Lm5vZGVzWzBdLnBhcmVudCA9PSByb290O1xuICAgICAqL1xuXG4gICAgLyoqXG4gICAgICogQG1lbWJlcm9mIE5vZGUjXG4gICAgICogQG1lbWJlciB7c291cmNlfSBzb3VyY2UgLSB0aGUgaW5wdXQgc291cmNlIG9mIHRoZSBub2RlXG4gICAgICpcbiAgICAgKiBUaGUgcHJvcGVydHkgaXMgdXNlZCBpbiBzb3VyY2UgbWFwIGdlbmVyYXRpb24uXG4gICAgICpcbiAgICAgKiBJZiB5b3UgY3JlYXRlIGEgbm9kZSBtYW51YWxseSAoZS5nLiwgd2l0aCBgcG9zdGNzcy5kZWNsKClgKSxcbiAgICAgKiB0aGF0IG5vZGUgd2lsbCBub3QgaGF2ZSBhIGBzb3VyY2VgIHByb3BlcnR5IGFuZCB3aWxsIGJlIGFic2VudFxuICAgICAqIGZyb20gdGhlIHNvdXJjZSBtYXAuIEZvciB0aGlzIHJlYXNvbiwgdGhlIHBsdWdpbiBkZXZlbG9wZXIgc2hvdWxkXG4gICAgICogY29uc2lkZXIgY2xvbmluZyBub2RlcyB0byBjcmVhdGUgbmV3IG9uZXMgKGluIHdoaWNoIGNhc2UgdGhlIG5ldyBub2Rl4oCZc1xuICAgICAqIHNvdXJjZSB3aWxsIHJlZmVyZW5jZSB0aGUgb3JpZ2luYWwsIGNsb25lZCBub2RlKSBvciBzZXR0aW5nXG4gICAgICogdGhlIGBzb3VyY2VgIHByb3BlcnR5IG1hbnVhbGx5LlxuICAgICAqXG4gICAgICogYGBganNcbiAgICAgKiAvLyBCYWRcbiAgICAgKiBjb25zdCBwcmVmaXhlZCA9IHBvc3Rjc3MuZGVjbCh7XG4gICAgICogICBwcm9wOiAnLW1vei0nICsgZGVjbC5wcm9wLFxuICAgICAqICAgdmFsdWU6IGRlY2wudmFsdWVcbiAgICAgKiB9KTtcbiAgICAgKlxuICAgICAqIC8vIEdvb2RcbiAgICAgKiBjb25zdCBwcmVmaXhlZCA9IGRlY2wuY2xvbmUoeyBwcm9wOiAnLW1vei0nICsgZGVjbC5wcm9wIH0pO1xuICAgICAqIGBgYFxuICAgICAqXG4gICAgICogYGBganNcbiAgICAgKiBpZiAoIGF0cnVsZS5uYW1lID09ICdhZGQtbGluaycgKSB7XG4gICAgICogICBjb25zdCBydWxlID0gcG9zdGNzcy5ydWxlKHsgc2VsZWN0b3I6ICdhJywgc291cmNlOiBhdHJ1bGUuc291cmNlIH0pO1xuICAgICAqICAgYXRydWxlLnBhcmVudC5pbnNlcnRCZWZvcmUoYXRydWxlLCBydWxlKTtcbiAgICAgKiB9XG4gICAgICogYGBgXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGRlY2wuc291cmNlLmlucHV0LmZyb20gLy89PiAnL2hvbWUvYWkvYS5zYXNzJ1xuICAgICAqIGRlY2wuc291cmNlLnN0YXJ0ICAgICAgLy89PiB7IGxpbmU6IDEwLCBjb2x1bW46IDIgfVxuICAgICAqIGRlY2wuc291cmNlLmVuZCAgICAgICAgLy89PiB7IGxpbmU6IDEwLCBjb2x1bW46IDEyIH1cbiAgICAgKi9cblxuICAgIC8qKlxuICAgICAqIEBtZW1iZXJvZiBOb2RlI1xuICAgICAqIEBtZW1iZXIge29iamVjdH0gcmF3cyAtIEluZm9ybWF0aW9uIHRvIGdlbmVyYXRlIGJ5dGUtdG8tYnl0ZSBlcXVhbFxuICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgIG5vZGUgc3RyaW5nIGFzIGl0IHdhcyBpbiB0aGUgb3JpZ2luIGlucHV0LlxuICAgICAqXG4gICAgICogRXZlcnkgcGFyc2VyIHNhdmVzIGl0cyBvd24gcHJvcGVydGllcyxcbiAgICAgKiBidXQgdGhlIGRlZmF1bHQgQ1NTIHBhcnNlciB1c2VzOlxuICAgICAqXG4gICAgICogKiBgYmVmb3JlYDogdGhlIHNwYWNlIHN5bWJvbHMgYmVmb3JlIHRoZSBub2RlLiBJdCBhbHNvIHN0b3JlcyBgKmBcbiAgICAgKiAgIGFuZCBgX2Agc3ltYm9scyBiZWZvcmUgdGhlIGRlY2xhcmF0aW9uIChJRSBoYWNrKS5cbiAgICAgKiAqIGBhZnRlcmA6IHRoZSBzcGFjZSBzeW1ib2xzIGFmdGVyIHRoZSBsYXN0IGNoaWxkIG9mIHRoZSBub2RlXG4gICAgICogICB0byB0aGUgZW5kIG9mIHRoZSBub2RlLlxuICAgICAqICogYGJldHdlZW5gOiB0aGUgc3ltYm9scyBiZXR3ZWVuIHRoZSBwcm9wZXJ0eSBhbmQgdmFsdWVcbiAgICAgKiAgIGZvciBkZWNsYXJhdGlvbnMsIHNlbGVjdG9yIGFuZCBge2AgZm9yIHJ1bGVzLCBvciBsYXN0IHBhcmFtZXRlclxuICAgICAqICAgYW5kIGB7YCBmb3IgYXQtcnVsZXMuXG4gICAgICogKiBgc2VtaWNvbG9uYDogY29udGFpbnMgdHJ1ZSBpZiB0aGUgbGFzdCBjaGlsZCBoYXNcbiAgICAgKiAgIGFuIChvcHRpb25hbCkgc2VtaWNvbG9uLlxuICAgICAqICogYGFmdGVyTmFtZWA6IHRoZSBzcGFjZSBiZXR3ZWVuIHRoZSBhdC1ydWxlIG5hbWUgYW5kIGl0cyBwYXJhbWV0ZXJzLlxuICAgICAqICogYGxlZnRgOiB0aGUgc3BhY2Ugc3ltYm9scyBiZXR3ZWVuIGAvKmAgYW5kIHRoZSBjb21tZW504oCZcyB0ZXh0LlxuICAgICAqICogYHJpZ2h0YDogdGhlIHNwYWNlIHN5bWJvbHMgYmV0d2VlbiB0aGUgY29tbWVudOKAmXMgdGV4dFxuICAgICAqICAgYW5kIDxjb2RlPiomIzQ3OzwvY29kZT4uXG4gICAgICogKiBgaW1wb3J0YW50YDogdGhlIGNvbnRlbnQgb2YgdGhlIGltcG9ydGFudCBzdGF0ZW1lbnQsXG4gICAgICogICBpZiBpdCBpcyBub3QganVzdCBgIWltcG9ydGFudGAuXG4gICAgICpcbiAgICAgKiBQb3N0Q1NTIGNsZWFucyBzZWxlY3RvcnMsIGRlY2xhcmF0aW9uIHZhbHVlcyBhbmQgYXQtcnVsZSBwYXJhbWV0ZXJzXG4gICAgICogZnJvbSBjb21tZW50cyBhbmQgZXh0cmEgc3BhY2VzLCBidXQgaXQgc3RvcmVzIG9yaWdpbiBjb250ZW50IGluIHJhd3NcbiAgICAgKiBwcm9wZXJ0aWVzLiBBcyBzdWNoLCBpZiB5b3UgZG9u4oCZdCBjaGFuZ2UgYSBkZWNsYXJhdGlvbuKAmXMgdmFsdWUsXG4gICAgICogUG9zdENTUyB3aWxsIHVzZSB0aGUgcmF3IHZhbHVlIHdpdGggY29tbWVudHMuXG4gICAgICpcbiAgICAgKiBAZXhhbXBsZVxuICAgICAqIGNvbnN0IHJvb3QgPSBwb3N0Y3NzLnBhcnNlKCdhIHtcXG4gIGNvbG9yOmJsYWNrXFxufScpXG4gICAgICogcm9vdC5maXJzdC5maXJzdC5yYXdzIC8vPT4geyBiZWZvcmU6ICdcXG4gICcsIGJldHdlZW46ICc6JyB9XG4gICAgICovXG5cbn1cblxuZXhwb3J0IGRlZmF1bHQgTm9kZTtcblxuLyoqXG4gKiBAdHlwZWRlZiB7b2JqZWN0fSBwb3NpdGlvblxuICogQHByb3BlcnR5IHtudW1iZXJ9IGxpbmUgICAtIHNvdXJjZSBsaW5lIGluIGZpbGVcbiAqIEBwcm9wZXJ0eSB7bnVtYmVyfSBjb2x1bW4gLSBzb3VyY2UgY29sdW1uIGluIGZpbGVcbiAqL1xuXG4vKipcbiAqIEB0eXBlZGVmIHtvYmplY3R9IHNvdXJjZVxuICogQHByb3BlcnR5IHtJbnB1dH0gaW5wdXQgICAgLSB7QGxpbmsgSW5wdXR9IHdpdGggaW5wdXQgZmlsZVxuICogQHByb3BlcnR5IHtwb3NpdGlvbn0gc3RhcnQgLSBUaGUgc3RhcnRpbmcgcG9zaXRpb24gb2YgdGhlIG5vZGXigJlzIHNvdXJjZVxuICogQHByb3BlcnR5IHtwb3NpdGlvbn0gZW5kICAgLSBUaGUgZW5kaW5nIHBvc2l0aW9uIG9mIHRoZSBub2Rl4oCZcyBzb3VyY2VcbiAqL1xuIl19
