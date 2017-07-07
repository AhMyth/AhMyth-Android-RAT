'use strict';

exports.__esModule = true;

var _declaration = require('./declaration');

var _declaration2 = _interopRequireDefault(_declaration);

var _tokenize = require('./tokenize');

var _tokenize2 = _interopRequireDefault(_tokenize);

var _comment = require('./comment');

var _comment2 = _interopRequireDefault(_comment);

var _atRule = require('./at-rule');

var _atRule2 = _interopRequireDefault(_atRule);

var _root = require('./root');

var _root2 = _interopRequireDefault(_root);

var _rule = require('./rule');

var _rule2 = _interopRequireDefault(_rule);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Parser = function () {
    function Parser(input) {
        _classCallCheck(this, Parser);

        this.input = input;

        this.pos = 0;
        this.root = new _root2.default();
        this.current = this.root;
        this.spaces = '';
        this.semicolon = false;

        this.root.source = { input: input, start: { line: 1, column: 1 } };
    }

    Parser.prototype.tokenize = function tokenize() {
        this.tokens = (0, _tokenize2.default)(this.input);
    };

    Parser.prototype.loop = function loop() {
        var token = void 0;
        while (this.pos < this.tokens.length) {
            token = this.tokens[this.pos];

            switch (token[0]) {

                case 'space':
                case ';':
                    this.spaces += token[1];
                    break;

                case '}':
                    this.end(token);
                    break;

                case 'comment':
                    this.comment(token);
                    break;

                case 'at-word':
                    this.atrule(token);
                    break;

                case '{':
                    this.emptyRule(token);
                    break;

                default:
                    this.other();
                    break;
            }

            this.pos += 1;
        }
        this.endFile();
    };

    Parser.prototype.comment = function comment(token) {
        var node = new _comment2.default();
        this.init(node, token[2], token[3]);
        node.source.end = { line: token[4], column: token[5] };

        var text = token[1].slice(2, -2);
        if (/^\s*$/.test(text)) {
            node.text = '';
            node.raws.left = text;
            node.raws.right = '';
        } else {
            var match = text.match(/^(\s*)([^]*[^\s])(\s*)$/);
            node.text = match[2];
            node.raws.left = match[1];
            node.raws.right = match[3];
        }
    };

    Parser.prototype.emptyRule = function emptyRule(token) {
        var node = new _rule2.default();
        this.init(node, token[2], token[3]);
        node.selector = '';
        node.raws.between = '';
        this.current = node;
    };

    Parser.prototype.other = function other() {
        var token = void 0;
        var end = false;
        var type = null;
        var colon = false;
        var bracket = null;
        var brackets = [];

        var start = this.pos;
        while (this.pos < this.tokens.length) {
            token = this.tokens[this.pos];
            type = token[0];

            if (type === '(' || type === '[') {
                if (!bracket) bracket = token;
                brackets.push(type === '(' ? ')' : ']');
            } else if (brackets.length === 0) {
                if (type === ';') {
                    if (colon) {
                        this.decl(this.tokens.slice(start, this.pos + 1));
                        return;
                    } else {
                        break;
                    }
                } else if (type === '{') {
                    this.rule(this.tokens.slice(start, this.pos + 1));
                    return;
                } else if (type === '}') {
                    this.pos -= 1;
                    end = true;
                    break;
                } else if (type === ':') {
                    colon = true;
                }
            } else if (type === brackets[brackets.length - 1]) {
                brackets.pop();
                if (brackets.length === 0) bracket = null;
            }

            this.pos += 1;
        }
        if (this.pos === this.tokens.length) {
            this.pos -= 1;
            end = true;
        }

        if (brackets.length > 0) this.unclosedBracket(bracket);

        if (end && colon) {
            while (this.pos > start) {
                token = this.tokens[this.pos][0];
                if (token !== 'space' && token !== 'comment') break;
                this.pos -= 1;
            }
            this.decl(this.tokens.slice(start, this.pos + 1));
            return;
        }

        this.unknownWord(start);
    };

    Parser.prototype.rule = function rule(tokens) {
        tokens.pop();

        var node = new _rule2.default();
        this.init(node, tokens[0][2], tokens[0][3]);

        node.raws.between = this.spacesFromEnd(tokens);
        this.raw(node, 'selector', tokens);
        this.current = node;
    };

    Parser.prototype.decl = function decl(tokens) {
        var node = new _declaration2.default();
        this.init(node);

        var last = tokens[tokens.length - 1];
        if (last[0] === ';') {
            this.semicolon = true;
            tokens.pop();
        }
        if (last[4]) {
            node.source.end = { line: last[4], column: last[5] };
        } else {
            node.source.end = { line: last[2], column: last[3] };
        }

        while (tokens[0][0] !== 'word') {
            node.raws.before += tokens.shift()[1];
        }
        node.source.start = { line: tokens[0][2], column: tokens[0][3] };

        node.prop = '';
        while (tokens.length) {
            var type = tokens[0][0];
            if (type === ':' || type === 'space' || type === 'comment') {
                break;
            }
            node.prop += tokens.shift()[1];
        }

        node.raws.between = '';

        var token = void 0;
        while (tokens.length) {
            token = tokens.shift();

            if (token[0] === ':') {
                node.raws.between += token[1];
                break;
            } else {
                node.raws.between += token[1];
            }
        }

        if (node.prop[0] === '_' || node.prop[0] === '*') {
            node.raws.before += node.prop[0];
            node.prop = node.prop.slice(1);
        }
        node.raws.between += this.spacesFromStart(tokens);
        this.precheckMissedSemicolon(tokens);

        for (var i = tokens.length - 1; i > 0; i--) {
            token = tokens[i];
            if (token[1] === '!important') {
                node.important = true;
                var string = this.stringFrom(tokens, i);
                string = this.spacesFromEnd(tokens) + string;
                if (string !== ' !important') node.raws.important = string;
                break;
            } else if (token[1] === 'important') {
                var cache = tokens.slice(0);
                var str = '';
                for (var j = i; j > 0; j--) {
                    var _type = cache[j][0];
                    if (str.trim().indexOf('!') === 0 && _type !== 'space') {
                        break;
                    }
                    str = cache.pop()[1] + str;
                }
                if (str.trim().indexOf('!') === 0) {
                    node.important = true;
                    node.raws.important = str;
                    tokens = cache;
                }
            }

            if (token[0] !== 'space' && token[0] !== 'comment') {
                break;
            }
        }

        this.raw(node, 'value', tokens);

        if (node.value.indexOf(':') !== -1) this.checkMissedSemicolon(tokens);
    };

    Parser.prototype.atrule = function atrule(token) {
        var node = new _atRule2.default();
        node.name = token[1].slice(1);
        if (node.name === '') {
            this.unnamedAtrule(node, token);
        }
        this.init(node, token[2], token[3]);

        var last = false;
        var open = false;
        var params = [];

        this.pos += 1;
        while (this.pos < this.tokens.length) {
            token = this.tokens[this.pos];

            if (token[0] === ';') {
                node.source.end = { line: token[2], column: token[3] };
                this.semicolon = true;
                break;
            } else if (token[0] === '{') {
                open = true;
                break;
            } else if (token[0] === '}') {
                this.end(token);
                break;
            } else {
                params.push(token);
            }

            this.pos += 1;
        }
        if (this.pos === this.tokens.length) {
            last = true;
        }

        node.raws.between = this.spacesFromEnd(params);
        if (params.length) {
            node.raws.afterName = this.spacesFromStart(params);
            this.raw(node, 'params', params);
            if (last) {
                token = params[params.length - 1];
                node.source.end = { line: token[4], column: token[5] };
                this.spaces = node.raws.between;
                node.raws.between = '';
            }
        } else {
            node.raws.afterName = '';
            node.params = '';
        }

        if (open) {
            node.nodes = [];
            this.current = node;
        }
    };

    Parser.prototype.end = function end(token) {
        if (this.current.nodes && this.current.nodes.length) {
            this.current.raws.semicolon = this.semicolon;
        }
        this.semicolon = false;

        this.current.raws.after = (this.current.raws.after || '') + this.spaces;
        this.spaces = '';

        if (this.current.parent) {
            this.current.source.end = { line: token[2], column: token[3] };
            this.current = this.current.parent;
        } else {
            this.unexpectedClose(token);
        }
    };

    Parser.prototype.endFile = function endFile() {
        if (this.current.parent) this.unclosedBlock();
        if (this.current.nodes && this.current.nodes.length) {
            this.current.raws.semicolon = this.semicolon;
        }
        this.current.raws.after = (this.current.raws.after || '') + this.spaces;
    };

    // Helpers

    Parser.prototype.init = function init(node, line, column) {
        this.current.push(node);

        node.source = { start: { line: line, column: column }, input: this.input };
        node.raws.before = this.spaces;
        this.spaces = '';
        if (node.type !== 'comment') this.semicolon = false;
    };

    Parser.prototype.raw = function raw(node, prop, tokens) {
        var token = void 0,
            type = void 0;
        var length = tokens.length;
        var value = '';
        var clean = true;
        for (var i = 0; i < length; i += 1) {
            token = tokens[i];
            type = token[0];
            if (type === 'comment' || type === 'space' && i === length - 1) {
                clean = false;
            } else {
                value += token[1];
            }
        }
        if (!clean) {
            var raw = tokens.reduce(function (all, i) {
                return all + i[1];
            }, '');
            node.raws[prop] = { value: value, raw: raw };
        }
        node[prop] = value;
    };

    Parser.prototype.spacesFromEnd = function spacesFromEnd(tokens) {
        var lastTokenType = void 0;
        var spaces = '';
        while (tokens.length) {
            lastTokenType = tokens[tokens.length - 1][0];
            if (lastTokenType !== 'space' && lastTokenType !== 'comment') break;
            spaces = tokens.pop()[1] + spaces;
        }
        return spaces;
    };

    Parser.prototype.spacesFromStart = function spacesFromStart(tokens) {
        var next = void 0;
        var spaces = '';
        while (tokens.length) {
            next = tokens[0][0];
            if (next !== 'space' && next !== 'comment') break;
            spaces += tokens.shift()[1];
        }
        return spaces;
    };

    Parser.prototype.stringFrom = function stringFrom(tokens, from) {
        var result = '';
        for (var i = from; i < tokens.length; i++) {
            result += tokens[i][1];
        }
        tokens.splice(from, tokens.length - from);
        return result;
    };

    Parser.prototype.colon = function colon(tokens) {
        var brackets = 0;
        var token = void 0,
            type = void 0,
            prev = void 0;
        for (var i = 0; i < tokens.length; i++) {
            token = tokens[i];
            type = token[0];

            if (type === '(') {
                brackets += 1;
            } else if (type === ')') {
                brackets -= 1;
            } else if (brackets === 0 && type === ':') {
                if (!prev) {
                    this.doubleColon(token);
                } else if (prev[0] === 'word' && prev[1] === 'progid') {
                    continue;
                } else {
                    return i;
                }
            }

            prev = token;
        }
        return false;
    };

    // Errors

    Parser.prototype.unclosedBracket = function unclosedBracket(bracket) {
        throw this.input.error('Unclosed bracket', bracket[2], bracket[3]);
    };

    Parser.prototype.unknownWord = function unknownWord(start) {
        var token = this.tokens[start];
        throw this.input.error('Unknown word', token[2], token[3]);
    };

    Parser.prototype.unexpectedClose = function unexpectedClose(token) {
        throw this.input.error('Unexpected }', token[2], token[3]);
    };

    Parser.prototype.unclosedBlock = function unclosedBlock() {
        var pos = this.current.source.start;
        throw this.input.error('Unclosed block', pos.line, pos.column);
    };

    Parser.prototype.doubleColon = function doubleColon(token) {
        throw this.input.error('Double colon', token[2], token[3]);
    };

    Parser.prototype.unnamedAtrule = function unnamedAtrule(node, token) {
        throw this.input.error('At-rule without name', token[2], token[3]);
    };

    Parser.prototype.precheckMissedSemicolon = function precheckMissedSemicolon(tokens) {
        // Hook for Safe Parser
        tokens;
    };

    Parser.prototype.checkMissedSemicolon = function checkMissedSemicolon(tokens) {
        var colon = this.colon(tokens);
        if (colon === false) return;

        var founded = 0;
        var token = void 0;
        for (var j = colon - 1; j >= 0; j--) {
            token = tokens[j];
            if (token[0] !== 'space') {
                founded += 1;
                if (founded === 2) break;
            }
        }
        throw this.input.error('Missed semicolon', token[2], token[3]);
    };

    return Parser;
}();

exports.default = Parser;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvcGFyc2VyLmVzNiJdLCJuYW1lcyI6WyJQYXJzZXIiLCJpbnB1dCIsInBvcyIsInJvb3QiLCJjdXJyZW50Iiwic3BhY2VzIiwic2VtaWNvbG9uIiwic291cmNlIiwic3RhcnQiLCJsaW5lIiwiY29sdW1uIiwidG9rZW5pemUiLCJ0b2tlbnMiLCJsb29wIiwidG9rZW4iLCJsZW5ndGgiLCJlbmQiLCJjb21tZW50IiwiYXRydWxlIiwiZW1wdHlSdWxlIiwib3RoZXIiLCJlbmRGaWxlIiwibm9kZSIsImluaXQiLCJ0ZXh0Iiwic2xpY2UiLCJ0ZXN0IiwicmF3cyIsImxlZnQiLCJyaWdodCIsIm1hdGNoIiwic2VsZWN0b3IiLCJiZXR3ZWVuIiwidHlwZSIsImNvbG9uIiwiYnJhY2tldCIsImJyYWNrZXRzIiwicHVzaCIsImRlY2wiLCJydWxlIiwicG9wIiwidW5jbG9zZWRCcmFja2V0IiwidW5rbm93bldvcmQiLCJzcGFjZXNGcm9tRW5kIiwicmF3IiwibGFzdCIsImJlZm9yZSIsInNoaWZ0IiwicHJvcCIsInNwYWNlc0Zyb21TdGFydCIsInByZWNoZWNrTWlzc2VkU2VtaWNvbG9uIiwiaSIsImltcG9ydGFudCIsInN0cmluZyIsInN0cmluZ0Zyb20iLCJjYWNoZSIsInN0ciIsImoiLCJ0cmltIiwiaW5kZXhPZiIsInZhbHVlIiwiY2hlY2tNaXNzZWRTZW1pY29sb24iLCJuYW1lIiwidW5uYW1lZEF0cnVsZSIsIm9wZW4iLCJwYXJhbXMiLCJhZnRlck5hbWUiLCJub2RlcyIsImFmdGVyIiwicGFyZW50IiwidW5leHBlY3RlZENsb3NlIiwidW5jbG9zZWRCbG9jayIsImNsZWFuIiwicmVkdWNlIiwiYWxsIiwibGFzdFRva2VuVHlwZSIsIm5leHQiLCJmcm9tIiwicmVzdWx0Iiwic3BsaWNlIiwicHJldiIsImRvdWJsZUNvbG9uIiwiZXJyb3IiLCJmb3VuZGVkIl0sIm1hcHBpbmdzIjoiOzs7O0FBQUE7Ozs7QUFDQTs7OztBQUNBOzs7O0FBQ0E7Ozs7QUFD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c0IsVUFBVSxLQUFmLEVBQXVCOztBQUV2QixZQUFJaUQsVUFBVSxDQUFkO0FBQ0EsWUFBSXJFLGNBQUo7QUFDQSxhQUFNLElBQUkyQyxJQUFJdkIsUUFBUSxDQUF0QixFQUF5QnVCLEtBQUssQ0FBOUIsRUFBaUNBLEdBQWpDLEVBQXVDO0FBQ25DM0Msb0JBQVFGLE9BQU82QyxDQUFQLENBQVI7QUFDQSxnQkFBSzNDLE1BQU0sQ0FBTixNQUFhLE9BQWxCLEVBQTRCO0FBQ3hCcUUsMkJBQVcsQ0FBWDtBQUNBLG9CQUFLQSxZQUFZLENBQWpCLEVBQXFCO0FBQ3hCO0FBQ0o7QUFDRCxjQUFNLEtBQUtsRixLQUFMLENBQVdpRixLQUFYLENBQWlCLGtCQUFqQixFQUFxQ3BFLE1BQU0sQ0FBTixDQUFyQyxFQUErQ0EsTUFBTSxDQUFOLENBQS9DLENBQU47QUFDSCxLOzs7OztrQkFoZGdCZCxNIiwiZmlsZSI6InBhcnNlci5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBEZWNsYXJhdGlvbiBmcm9tICcuL2RlY2xhcmF0aW9uJztcbmltcG9ydCB0b2tlbml6ZXIgICBmcm9tICcuL3Rva2VuaXplJztcbmltcG9ydCBDb21tZW50ICAgICBmcm9tICcuL2NvbW1lbnQnO1xuaW1wb3J0IEF0UnVsZSAgICAgIGZyb20gJy4vYXQtcnVsZSc7XG5pbXBvcnQgUm9vdCAgICAgICAgZnJvbSAnLi9yb290JztcbmltcG9ydCBSdWxlICAgICAgICBmcm9tICcuL3J1bGUnO1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBQYXJzZXIge1xuXG4gICAgY29uc3RydWN0b3IoaW5wdXQpIHtcbiAgICAgICAgdGhpcy5pbnB1dCA9IGlucHV0O1xuXG4gICAgICAgIHRoaXMucG9zICAgICAgID0gMDtcbiAgICAgICAgdGhpcy5yb290ICAgICAgPSBuZXcgUm9vdCgpO1xuICAgICAgICB0aGlzLmN1cnJlbnQgICA9IHRoaXMucm9vdDtcbiAgICAgICAgdGhpcy5zcGFjZXMgICAgPSAnJztcbiAgICAgICAgdGhpcy5zZW1pY29sb24gPSBmYWxzZTtcblxuICAgICAgICB0aGlzLnJvb3Quc291cmNlID0geyBpbnB1dCwgc3RhcnQ6IHsgbGluZTogMSwgY29sdW1uOiAxIH0gfTtcbiAgICB9XG5cbiAgICB0b2tlbml6ZSgpIHtcbiAgICAgICAgdGhpcy50b2tlbnMgPSB0b2tlbml6ZXIodGhpcy5pbnB1dCk7XG4gICAgfVxuXG4gICAgbG9vcCgpIHtcbiAgICAgICAgbGV0IHRva2VuO1xuICAgICAgICB3aGlsZSAoIHRoaXMucG9zIDwgdGhpcy50b2tlbnMubGVuZ3RoICkge1xuICAgICAgICAgICAgdG9rZW4gPSB0aGlzLnRva2Vuc1t0aGlzLnBvc107XG5cbiAgICAgICAgICAgIHN3aXRjaCAoIHRva2VuWzBdICkge1xuXG4gICAgICAgICAgICBjYXNlICdzcGFjZSc6XG4gICAgICAgICAgICBjYXNlICc7JzpcbiAgICAgICAgICAgICAgICB0aGlzLnNwYWNlcyArPSB0b2tlblsxXTtcbiAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgY2FzZSAnfSc6XG4gICAgICAgICAgICAgICAgdGhpcy5lbmQodG9rZW4pO1xuICAgICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlICdjb21tZW50JzpcbiAgICAgICAgICAgICAgICB0aGlzLmNvbW1lbnQodG9rZW4pO1xuICAgICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlICdhdC13b3JkJzpcbiAgICAgICAgICAgICAgICB0aGlzLmF0cnVsZSh0b2tlbik7XG4gICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgIGNhc2UgJ3snOlxuICAgICAgICAgICAgICAgIHRoaXMuZW1wdHlSdWxlKHRva2VuKTtcbiAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgZGVmYXVsdDpcbiAgICAgICAgICAgICAgICB0aGlzLm90aGVyKCk7XG4gICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICB9XG5cbiAgICAgICAgICAgIHRoaXMucG9zICs9IDE7XG4gICAgICAgIH1cbiAgICAgICAgdGhpcy5lbmRGaWxlKCk7XG4gICAgfVxuXG4gICAgY29tbWVudCh0b2tlbikge1xuICAgICAgICBsZXQgbm9kZSA9IG5ldyBDb21tZW50KCk7XG4gICAgICAgIHRoaXMuaW5pdChub2RlLCB0b2tlblsyXSwgdG9rZW5bM10pO1xuICAgICAgICBub2RlLnNvdXJjZS5lbmQgPSB7IGxpbmU6IHRva2VuWzRdLCBjb2x1bW46IHRva2VuWzVdIH07XG5cbiAgICAgICAgbGV0IHRleHQgPSB0b2tlblsxXS5zbGljZSgyLCAtMik7XG4gICAgICAgIGlmICggL15cXHMqJC8udGVzdCh0ZXh0KSApIHtcbiAgICAgICAgICAgIG5vZGUudGV4dCAgICAgICA9ICcnO1xuICAgICAgICAgICAgbm9kZS5yYXdzLmxlZnQgID0gdGV4dDtcbiAgICAgICAgICAgIG5vZGUucmF3cy5yaWdodCA9ICcnO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgbGV0IG1hdGNoID0gdGV4dC5tYXRjaCgvXihcXHMqKShbXl0qW15cXHNdKShcXHMqKSQvKTtcbiAgICAgICAgICAgIG5vZGUudGV4dCAgICAgICA9IG1hdGNoWzJdO1xuICAgICAgICAgICAgbm9kZS5yYXdzLmxlZnQgID0gbWF0Y2hbMV07XG4gICAgICAgICAgICBub2RlLnJhd3MucmlnaHQgPSBtYXRjaFszXTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIGVtcHR5UnVsZSh0b2tlbikge1xuICAgICAgICBsZXQgbm9kZSA9IG5ldyBSdWxlKCk7XG4gICAgICAgIHRoaXMuaW5pdChub2RlLCB0b2tlblsyXSwgdG9rZW5bM10pO1xuICAgICAgICBub2RlLnNlbGVjdG9yID0gJyc7XG4gICAgICAgIG5vZGUucmF3cy5iZXR3ZWVuID0gJyc7XG4gICAgICAgIHRoaXMuY3VycmVudCA9IG5vZGU7XG4gICAgfVxuXG4gICAgb3RoZXIoKSB7XG4gICAgICAgIGxldCB0b2tlbjtcbiAgICAgICAgbGV0IGVuZCAgICAgID0gZmFsc2U7XG4gICAgICAgIGxldCB0eXBlICAgICA9IG51bGw7XG4gICAgICAgIGxldCBjb2xvbiAgICA9IGZhbHNlO1xuICAgICAgICBsZXQgYnJhY2tldCAgPSBudWxsO1xuICAgICAgICBsZXQgYnJhY2tldHMgPSBbXTtcblxuICAgICAgICBsZXQgc3RhcnQgPSB0aGlzLnBvcztcbiAgICAgICAgd2hpbGUgKCB0aGlzLnBvcyA8IHRoaXMudG9rZW5zLmxlbmd0aCApIHtcbiAgICAgICAgICAgIHRva2VuID0gdGhpcy50b2tlbnNbdGhpcy5wb3NdO1xuICAgICAgICAgICAgdHlwZSAgPSB0b2tlblswXTtcblxuICAgICAgICAgICAgaWYgKCB0eXBlID09PSAnKCcgfHwgdHlwZSA9PT0gJ1snICkge1xuICAgICAgICAgICAgICAgIGlmICggIWJyYWNrZXQgKSBicmFja2V0ID0gdG9rZW47XG4gICAgICAgICAgICAgICAgYnJhY2tldHMucHVzaCh0eXBlID09PSAnKCcgPyAnKScgOiAnXScpO1xuXG4gICAgICAgICAgICB9IGVsc2UgaWYgKCBicmFja2V0cy5sZW5ndGggPT09IDAgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCB0eXBlID09PSAnOycgKSB7XG4gICAgICAgICAgICAgICAgICAgIGlmICggY29sb24gKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICB0aGlzLmRlY2wodGhpcy50b2tlbnMuc2xpY2Uoc3RhcnQsIHRoaXMucG9zICsgMSkpO1xuICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuO1xuICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoIHR5cGUgPT09ICd7JyApIHtcbiAgICAgICAgICAgICAgICAgICAgdGhpcy5ydWxlKHRoaXMudG9rZW5zLnNsaWNlKHN0YXJ0LCB0aGlzLnBvcyArIDEpKTtcbiAgICAgICAgICAgICAgICAgICAgcmV0dXJuO1xuXG4gICAgICAgICAgICAgICAgfSBlbHNlIGlmICggdHlwZSA9PT0gJ30nICkge1xuICAgICAgICAgICAgICAgICAgICB0aGlzLnBvcyAtPSAxO1xuICAgICAgICAgICAgICAgICAgICBlbmQgPSB0cnVlO1xuICAgICAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoIHR5cGUgPT09ICc6JyApIHtcbiAgICAgICAgICAgICAgICAgICAgY29sb24gPSB0cnVlO1xuICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgfSBlbHNlIGlmICggdHlwZSA9PT0gYnJhY2tldHNbYnJhY2tldHMubGVuZ3RoIC0gMV0gKSB7XG4gICAgICAgICAgICAgICAgYnJhY2tldHMucG9wKCk7XG4gICAgICAgICAgICAgICAgaWYgKCBicmFja2V0cy5sZW5ndGggPT09IDAgKSBicmFja2V0ID0gbnVsbDtcbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgdGhpcy5wb3MgKz0gMTtcbiAgICAgICAgfVxuICAgICAgICBpZiAoIHRoaXMucG9zID09PSB0aGlzLnRva2Vucy5sZW5ndGggKSB7XG4gICAgICAgICAgICB0aGlzLnBvcyAtPSAxO1xuICAgICAgICAgICAgZW5kID0gdHJ1ZTtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmICggYnJhY2tldHMubGVuZ3RoID4gMCApIHRoaXMudW5jbG9zZWRCcmFja2V0KGJyYWNrZXQpO1xuXG4gICAgICAgIGlmICggZW5kICYmIGNvbG9uICkge1xuICAgICAgICAgICAgd2hpbGUgKCB0aGlzLnBvcyA+IHN0YXJ0ICkge1xuICAgICAgICAgICAgICAgIHRva2VuID0gdGhpcy50b2tlbnNbdGhpcy5wb3NdWzBdO1xuICAgICAgICAgICAgICAgIGlmICggdG9rZW4gIT09ICdzcGFjZScgJiYgdG9rZW4gIT09ICdjb21tZW50JyApIGJyZWFrO1xuICAgICAgICAgICAgICAgIHRoaXMucG9zIC09IDE7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICB0aGlzLmRlY2wodGhpcy50b2tlbnMuc2xpY2Uoc3RhcnQsIHRoaXMucG9zICsgMSkpO1xuICAgICAgICAgICAgcmV0dXJuO1xuICAgICAgICB9XG5cbiAgICAgICAgdGhpcy51bmtub3duV29yZChzdGFydCk7XG4gICAgfVxuXG4gICAgcnVsZSh0b2tlbnMpIHtcbiAgICAgICAgdG9rZW5zLnBvcCgpO1xuXG4gICAgICAgIGxldCBub2RlID0gbmV3IFJ1bGUoKTtcbiAgICAgICAgdGhpcy5pbml0KG5vZGUsIHRva2Vuc1swXVsyXSwgdG9rZW5zWzBdWzNdKTtcblxuICAgICAgICBub2RlLnJhd3MuYmV0d2VlbiA9IHRoaXMuc3BhY2VzRnJvbUVuZCh0b2tlbnMpO1xuICAgICAgICB0aGlzLnJhdyhub2RlLCAnc2VsZWN0b3InLCB0b2tlbnMpO1xuICAgICAgICB0aGlzLmN1cnJlbnQgPSBub2RlO1xuICAgIH1cblxuICAgIGRlY2wodG9rZW5zKSB7XG4gICAgICAgIGxldCBub2RlID0gbmV3IERlY2xhcmF0aW9uKCk7XG4gICAgICAgIHRoaXMuaW5pdChub2RlKTtcblxuICAgICAgICBsZXQgbGFzdCA9IHRva2Vuc1t0b2tlbnMubGVuZ3RoIC0gMV07XG4gICAgICAgIGlmICggbGFzdFswXSA9PT0gJzsnICkge1xuICAgICAgICAgICAgdGhpcy5zZW1pY29sb24gPSB0cnVlO1xuICAgICAgICAgICAgdG9rZW5zLnBvcCgpO1xuICAgICAgICB9XG4gICAgICAgIGlmICggbGFzdFs0XSApIHtcbiAgICAgICAgICAgIG5vZGUuc291cmNlLmVuZCA9IHsgbGluZTogbGFzdFs0XSwgY29sdW1uOiBsYXN0WzVdIH07XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICBub2RlLnNvdXJjZS5lbmQgPSB7IGxpbmU6IGxhc3RbMl0sIGNvbHVtbjogbGFzdFszXSB9O1xuICAgICAgICB9XG5cbiAgICAgICAgd2hpbGUgKCB0b2tlbnNbMF1bMF0gIT09ICd3b3JkJyApIHtcbiAgICAgICAgICAgIG5vZGUucmF3cy5iZWZvcmUgKz0gdG9rZW5zLnNoaWZ0KClbMV07XG4gICAgICAgIH1cbiAgICAgICAgbm9kZS5zb3VyY2Uuc3RhcnQgPSB7IGxpbmU6IHRva2Vuc1swXVsyXSwgY29sdW1uOiB0b2tlbnNbMF1bM10gfTtcblxuICAgICAgICBub2RlLnByb3AgPSAnJztcbiAgICAgICAgd2hpbGUgKCB0b2tlbnMubGVuZ3RoICkge1xuICAgICAgICAgICAgbGV0IHR5cGUgPSB0b2tlbnNbMF1bMF07XG4gICAgICAgICAgICBpZiAoIHR5cGUgPT09ICc6JyB8fCB0eXBlID09PSAnc3BhY2UnIHx8IHR5cGUgPT09ICdjb21tZW50JyApIHtcbiAgICAgICAgICAgICAgICBicmVhaztcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIG5vZGUucHJvcCArPSB0b2tlbnMuc2hpZnQoKVsxXTtcbiAgICAgICAgfVxuXG4gICAgICAgIG5vZGUucmF3cy5iZXR3ZWVuID0gJyc7XG5cbiAgICAgICAgbGV0IHRva2VuO1xuICAgICAgICB3aGlsZSAoIHRva2Vucy5sZW5ndGggKSB7XG4gICAgICAgICAgICB0b2tlbiA9IHRva2Vucy5zaGlmdCgpO1xuXG4gICAgICAgICAgICBpZiAoIHRva2VuWzBdID09PSAnOicgKSB7XG4gICAgICAgICAgICAgICAgbm9kZS5yYXdzLmJldHdlZW4gKz0gdG9rZW5bMV07XG4gICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIG5vZGUucmF3cy5iZXR3ZWVuICs9IHRva2VuWzFdO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG5cbiAgICAgICAgaWYgKCBub2RlLnByb3BbMF0gPT09ICdfJyB8fCBub2RlLnByb3BbMF0gPT09ICcqJyApIHtcbiAgICAgICAgICAgIG5vZGUucmF3cy5iZWZvcmUgKz0gbm9kZS5wcm9wWzBdO1xuICAgICAgICAgICAgbm9kZS5wcm9wID0gbm9kZS5wcm9wLnNsaWNlKDEpO1xuICAgICAgICB9XG4gICAgICAgIG5vZGUucmF3cy5iZXR3ZWVuICs9IHRoaXMuc3BhY2VzRnJvbVN0YXJ0KHRva2Vucyk7XG4gICAgICAgIHRoaXMucHJlY2hlY2tNaXNzZWRTZW1pY29sb24odG9rZW5zKTtcblxuICAgICAgICBmb3IgKCBsZXQgaSA9IHRva2Vucy5sZW5ndGggLSAxOyBpID4gMDsgaS0tICkge1xuICAgICAgICAgICAgdG9rZW4gPSB0b2tlbnNbaV07XG4gICAgICAgICAgICBpZiAoIHRva2VuWzFdID09PSAnIWltcG9ydGFudCcgKSB7XG4gICAgICAgICAgICAgICAgbm9kZS5pbXBvcnRhbnQgPSB0cnVlO1xuICAgICAgICAgICAgICAgIGxldCBzdHJpbmcgPSB0aGlzLnN0cmluZ0Zyb20odG9rZW5zLCBpKTtcbiAgICAgICAgICAgICAgICBzdHJpbmcgPSB0aGlzLnNwYWNlc0Zyb21FbmQodG9rZW5zKSArIHN0cmluZztcbiAgICAgICAgICAgICAgICBpZiAoIHN0cmluZyAhPT0gJyAhaW1wb3J0YW50JyApIG5vZGUucmF3cy5pbXBvcnRhbnQgPSBzdHJpbmc7XG4gICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgIH0gZWxzZSBpZiAodG9rZW5bMV0gPT09ICdpbXBvcnRhbnQnKSB7XG4gICAgICAgICAgICAgICAgbGV0IGNhY2hlID0gdG9rZW5zLnNsaWNlKDApO1xuICAgICAgICAgICAgICAgIGxldCBzdHIgICA9ICcnO1xuICAgICAgICAgICAgICAgIGZvciAoIGxldCBqID0gaTsgaiA+IDA7IGotLSApIHtcbiAgICAgICAgICAgICAgICAgICAgbGV0IHR5cGUgPSBjYWNoZVtqXVswXTtcbiAgICAgICAgICAgICAgICAgICAgaWYgKCBzdHIudHJpbSgpLmluZGV4T2YoJyEnKSA9PT0gMCAmJiB0eXBlICE9PSAnc3BhY2UnICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgc3RyID0gY2FjaGUucG9wKClbMV0gKyBzdHI7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIGlmICggc3RyLnRyaW0oKS5pbmRleE9mKCchJykgPT09IDAgKSB7XG4gICAgICAgICAgICAgICAgICAgIG5vZGUuaW1wb3J0YW50ID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICAgICAgbm9kZS5yYXdzLmltcG9ydGFudCA9IHN0cjtcbiAgICAgICAgICAgICAgICAgICAgdG9rZW5zID0gY2FjaGU7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICBpZiAoIHRva2VuWzBdICE9PSAnc3BhY2UnICYmIHRva2VuWzBdICE9PSAnY29tbWVudCcgKSB7XG4gICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cblxuICAgICAgICB0aGlzLnJhdyhub2RlLCAndmFsdWUnLCB0b2tlbnMpO1xuXG4gICAgICAgIGlmICggbm9kZS52YWx1ZS5pbmRleE9mKCc6JykgIT09IC0xICkgdGhpcy5jaGVja01pc3NlZFNlbWljb2xvbih0b2tlbnMpO1xuICAgIH1cblxuICAgIGF0cnVsZSh0b2tlbikge1xuICAgICAgICBsZXQgbm9kZSAgPSBuZXcgQXRSdWxlKCk7XG4gICAgICAgIG5vZGUubmFtZSA9IHRva2VuWzFdLnNsaWNlKDEpO1xuICAgICAgICBpZiAoIG5vZGUubmFtZSA9PT0gJycgKSB7XG4gICAgICAgICAgICB0aGlzLnVubmFtZWRBdHJ1bGUobm9kZSwgdG9rZW4pO1xuICAgICAgICB9XG4gICAgICAgIHRoaXMuaW5pdChub2RlLCB0b2tlblsyXSwgdG9rZW5bM10pO1xuXG4gICAgICAgIGxldCBsYXN0ICAgPSBmYWxzZTtcbiAgICAgICAgbGV0IG9wZW4gICA9IGZhbHNlO1xuICAgICAgICBsZXQgcGFyYW1zID0gW107XG5cbiAgICAgICAgdGhpcy5wb3MgKz0gMTtcbiAgICAgICAgd2hpbGUgKCB0aGlzLnBvcyA8IHRoaXMudG9rZW5zLmxlbmd0aCApIHtcbiAgICAgICAgICAgIHRva2VuID0gdGhpcy50b2tlbnNbdGhpcy5wb3NdO1xuXG4gICAgICAgICAgICBpZiAoIHRva2VuWzBdID09PSAnOycgKSB7XG4gICAgICAgICAgICAgICAgbm9kZS5zb3VyY2UuZW5kID0geyBsaW5lOiB0b2tlblsyXSwgY29sdW1uOiB0b2tlblszXSB9O1xuICAgICAgICAgICAgICAgIHRoaXMuc2VtaWNvbG9uID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICBicmVhaztcbiAgICAgICAgICAgIH0gZWxzZSBpZiAoIHRva2VuWzBdID09PSAneycgKSB7XG4gICAgICAgICAgICAgICAgb3BlbiA9IHRydWU7XG4gICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKCB0b2tlblswXSA9PT0gJ30nKSB7XG4gICAgICAgICAgICAgICAgdGhpcy5lbmQodG9rZW4pO1xuICAgICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICBwYXJhbXMucHVzaCh0b2tlbik7XG4gICAgICAgICAgICB9XG5cbiAgICAgICAgICAgIHRoaXMucG9zICs9IDE7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKCB0aGlzLnBvcyA9PT0gdGhpcy50b2tlbnMubGVuZ3RoICkge1xuICAgICAgICAgICAgbGFzdCA9IHRydWU7XG4gICAgICAgIH1cblxuICAgICAgICBub2RlLnJhd3MuYmV0d2VlbiA9IHRoaXMuc3BhY2VzRnJvbUVuZChwYXJhbXMpO1xuICAgICAgICBpZiAoIHBhcmFtcy5sZW5ndGggKSB7XG4gICAgICAgICAgICBub2RlLnJhd3MuYWZ0ZXJOYW1lID0gdGhpcy5zcGFjZXNGcm9tU3RhcnQocGFyYW1zKTtcbiAgICAgICAgICAgIHRoaXMucmF3KG5vZGUsICdwYXJhbXMnLCBwYXJhbXMpO1xuICAgICAgICAgICAgaWYgKCBsYXN0ICkge1xuICAgICAgICAgICAgICAgIHRva2VuID0gcGFyYW1zW3BhcmFtcy5sZW5ndGggLSAxXTtcbiAgICAgICAgICAgICAgICBub2RlLnNvdXJjZS5lbmQgICA9IHsgbGluZTogdG9rZW5bNF0sIGNvbHVtbjogdG9rZW5bNV0gfTtcbiAgICAgICAgICAgICAgICB0aGlzLnNwYWNlcyAgICAgICA9IG5vZGUucmF3cy5iZXR3ZWVuO1xuICAgICAgICAgICAgICAgIG5vZGUucmF3cy5iZXR3ZWVuID0gJyc7XG4gICAgICAgICAgICB9XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICBub2RlLnJhd3MuYWZ0ZXJOYW1lID0gJyc7XG4gICAgICAgICAgICBub2RlLnBhcmFtcyAgICAgICAgID0gJyc7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoIG9wZW4gKSB7XG4gICAgICAgICAgICBub2RlLm5vZGVzICAgPSBbXTtcbiAgICAgICAgICAgIHRoaXMuY3VycmVudCA9IG5vZGU7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBlbmQodG9rZW4pIHtcbiAgICAgICAgaWYgKCB0aGlzLmN1cnJlbnQubm9kZXMgJiYgdGhpcy5jdXJyZW50Lm5vZGVzLmxlbmd0aCApIHtcbiAgICAgICAgICAgIHRoaXMuY3VycmVudC5yYXdzLnNlbWljb2xvbiA9IHRoaXMuc2VtaWNvbG9uO1xuICAgICAgICB9XG4gICAgICAgIHRoaXMuc2VtaWNvbG9uID0gZmFsc2U7XG5cbiAgICAgICAgdGhpcy5jdXJyZW50LnJhd3MuYWZ0ZXIgPSAodGhpcy5jdXJyZW50LnJhd3MuYWZ0ZXIgfHwgJycpICsgdGhpcy5zcGFjZXM7XG4gICAgICAgIHRoaXMuc3BhY2VzID0gJyc7XG5cbiAgICAgICAgaWYgKCB0aGlzLmN1cnJlbnQucGFyZW50ICkge1xuICAgICAgICAgICAgdGhpcy5jdXJyZW50LnNvdXJjZS5lbmQgPSB7IGxpbmU6IHRva2VuWzJdLCBjb2x1bW46IHRva2VuWzNdIH07XG4gICAgICAgICAgICB0aGlzLmN1cnJlbnQgPSB0aGlzLmN1cnJlbnQucGFyZW50O1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgdGhpcy51bmV4cGVjdGVkQ2xvc2UodG9rZW4pO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgZW5kRmlsZSgpIHtcbiAgICAgICAgaWYgKCB0aGlzLmN1cnJlbnQucGFyZW50ICkgdGhpcy51bmNsb3NlZEJsb2NrKCk7XG4gICAgICAgIGlmICggdGhpcy5jdXJyZW50Lm5vZGVzICYmIHRoaXMuY3VycmVudC5ub2Rlcy5sZW5ndGggKSB7XG4gICAgICAgICAgICB0aGlzLmN1cnJlbnQucmF3cy5zZW1pY29sb24gPSB0aGlzLnNlbWljb2xvbjtcbiAgICAgICAgfVxuICAgICAgICB0aGlzLmN1cnJlbnQucmF3cy5hZnRlciA9ICh0aGlzLmN1cnJlbnQucmF3cy5hZnRlciB8fCAnJykgKyB0aGlzLnNwYWNlcztcbiAgICB9XG5cbiAgICAvLyBIZWxwZXJzXG5cbiAgICBpbml0KG5vZGUsIGxpbmUsIGNvbHVtbikge1xuICAgICAgICB0aGlzLmN1cnJlbnQucHVzaChub2RlKTtcblxuICAgICAgICBub2RlLnNvdXJjZSA9IHsgc3RhcnQ6IHsgbGluZSwgY29sdW1uIH0sIGlucHV0OiB0aGlzLmlucHV0IH07XG4gICAgICAgIG5vZGUucmF3cy5iZWZvcmUgPSB0aGlzLnNwYWNlcztcbiAgICAgICAgdGhpcy5zcGFjZXMgPSAnJztcbiAgICAgICAgaWYgKCBub2RlLnR5cGUgIT09ICdjb21tZW50JyApIHRoaXMuc2VtaWNvbG9uID0gZmFsc2U7XG4gICAgfVxuXG4gICAgcmF3KG5vZGUsIHByb3AsIHRva2Vucykge1xuICAgICAgICBsZXQgdG9rZW4sIHR5cGU7XG4gICAgICAgIGxldCBsZW5ndGggPSB0b2tlbnMubGVuZ3RoO1xuICAgICAgICBsZXQgdmFsdWUgID0gJyc7XG4gICAgICAgIGxldCBjbGVhbiAgPSB0cnVlO1xuICAgICAgICBmb3IgKCBsZXQgaSA9IDA7IGkgPCBsZW5ndGg7IGkgKz0gMSApIHtcbiAgICAgICAgICAgIHRva2VuID0gdG9rZW5zW2ldO1xuICAgICAgICAgICAgdHlwZSAgPSB0b2tlblswXTtcbiAgICAgICAgICAgIGlmICggdHlwZSA9PT0gJ2NvbW1lbnQnIHx8IHR5cGUgPT09ICdzcGFjZScgJiYgaSA9PT0gbGVuZ3RoIC0gMSApIHtcbiAgICAgICAgICAgICAgICBjbGVhbiA9IGZhbHNlO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICB2YWx1ZSArPSB0b2tlblsxXTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICBpZiAoICFjbGVhbiApIHtcbiAgICAgICAgICAgIGxldCByYXcgPSB0b2tlbnMucmVkdWNlKCAoYWxsLCBpKSA9PiBhbGwgKyBpWzFdLCAnJyk7XG4gICAgICAgICAgICBub2RlLnJhd3NbcHJvcF0gPSB7IHZhbHVlLCByYXcgfTtcbiAgICAgICAgfVxuICAgICAgICBub2RlW3Byb3BdID0gdmFsdWU7XG4gICAgfVxuXG4gICAgc3BhY2VzRnJvbUVuZCh0b2tlbnMpIHtcbiAgICAgICAgbGV0IGxhc3RUb2tlblR5cGU7XG4gICAgICAgIGxldCBzcGFjZXMgPSAnJztcbiAgICAgICAgd2hpbGUgKCB0b2tlbnMubGVuZ3RoICkge1xuICAgICAgICAgICAgbGFzdFRva2VuVHlwZSA9IHRva2Vuc1t0b2tlbnMubGVuZ3RoIC0gMV1bMF07XG4gICAgICAgICAgICBpZiAoIGxhc3RUb2tlblR5cGUgIT09ICdzcGFjZScgJiZcbiAgICAgICAgICAgICAgICBsYXN0VG9rZW5UeXBlICE9PSAnY29tbWVudCcgKSBicmVhaztcbiAgICAgICAgICAgIHNwYWNlcyA9IHRva2Vucy5wb3AoKVsxXSArIHNwYWNlcztcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gc3BhY2VzO1xuICAgIH1cblxuICAgIHNwYWNlc0Zyb21TdGFydCh0b2tlbnMpIHtcbiAgICAgICAgbGV0IG5leHQ7XG4gICAgICAgIGxldCBzcGFjZXMgPSAnJztcbiAgICAgICAgd2hpbGUgKCB0b2tlbnMubGVuZ3RoICkge1xuICAgICAgICAgICAgbmV4dCA9IHRva2Vuc1swXVswXTtcbiAgICAgICAgICAgIGlmICggbmV4dCAhPT0gJ3NwYWNlJyAmJiBuZXh0ICE9PSAnY29tbWVudCcgKSBicmVhaztcbiAgICAgICAgICAgIHNwYWNlcyArPSB0b2tlbnMuc2hpZnQoKVsxXTtcbiAgICAgICAgfVxuICAgICAgICByZXR1cm4gc3BhY2VzO1xuICAgIH1cblxuICAgIHN0cmluZ0Zyb20odG9rZW5zLCBmcm9tKSB7XG4gICAgICAgIGxldCByZXN1bHQgPSAnJztcbiAgICAgICAgZm9yICggbGV0IGkgPSBmcm9tOyBpIDwgdG9rZW5zLmxlbmd0aDsgaSsrICkge1xuICAgICAgICAgICAgcmVzdWx0ICs9IHRva2Vuc1tpXVsxXTtcbiAgICAgICAgfVxuICAgICAgICB0b2tlbnMuc3BsaWNlKGZyb20sIHRva2Vucy5sZW5ndGggLSBmcm9tKTtcbiAgICAgICAgcmV0dXJuIHJlc3VsdDtcbiAgICB9XG5cbiAgICBjb2xvbih0b2tlbnMpIHtcbiAgICAgICAgbGV0IGJyYWNrZXRzID0gMDtcbiAgICAgICAgbGV0IHRva2VuLCB0eXBlLCBwcmV2O1xuICAgICAgICBmb3IgKCBsZXQgaSA9IDA7IGkgPCB0b2tlbnMubGVuZ3RoOyBpKysgKSB7XG4gICAgICAgICAgICB0b2tlbiA9IHRva2Vuc1tpXTtcbiAgICAgICAgICAgIHR5cGUgID0gdG9rZW5bMF07XG5cbiAgICAgICAgICAgIGlmICggdHlwZSA9PT0gJygnICkge1xuICAgICAgICAgICAgICAgIGJyYWNrZXRzICs9IDE7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKCB0eXBlID09PSAnKScgKSB7XG4gICAgICAgICAgICAgICAgYnJhY2tldHMgLT0gMTtcbiAgICAgICAgICAgIH0gZWxzZSBpZiAoIGJyYWNrZXRzID09PSAwICYmIHR5cGUgPT09ICc6JyApIHtcbiAgICAgICAgICAgICAgICBpZiAoICFwcmV2ICkge1xuICAgICAgICAgICAgICAgICAgICB0aGlzLmRvdWJsZUNvbG9uKHRva2VuKTtcbiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKCBwcmV2WzBdID09PSAnd29yZCcgJiYgcHJldlsxXSA9PT0gJ3Byb2dpZCcgKSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlO1xuICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiBpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgcHJldiA9IHRva2VuO1xuICAgICAgICB9XG4gICAgICAgIHJldHVybiBmYWxzZTtcbiAgICB9XG5cbiAgICAvLyBFcnJvcnNcblxuICAgIHVuY2xvc2VkQnJhY2tldChicmFja2V0KSB7XG4gICAgICAgIHRocm93IHRoaXMuaW5wdXQuZXJyb3IoJ1VuY2xvc2VkIGJyYWNrZXQnLCBicmFja2V0WzJdLCBicmFja2V0WzNdKTtcbiAgICB9XG5cbiAgICB1bmtub3duV29yZChzdGFydCkge1xuICAgICAgICBsZXQgdG9rZW4gPSB0aGlzLnRva2Vuc1tzdGFydF07XG4gICAgICAgIHRocm93IHRoaXMuaW5wdXQuZXJyb3IoJ1Vua25vd24gd29yZCcsIHRva2VuWzJdLCB0b2tlblszXSk7XG4gICAgfVxuXG4gICAgdW5leHBlY3RlZENsb3NlKHRva2VuKSB7XG4gICAgICAgIHRocm93IHRoaXMuaW5wdXQuZXJyb3IoJ1VuZXhwZWN0ZWQgfScsIHRva2VuWzJdLCB0b2tlblszXSk7XG4gICAgfVxuXG4gICAgdW5jbG9zZWRCbG9jaygpIHtcbiAgICAgICAgbGV0IHBvcyA9IHRoaXMuY3VycmVudC5zb3VyY2Uuc3RhcnQ7XG4gICAgICAgIHRocm93IHRoaXMuaW5wdXQuZXJyb3IoJ1VuY2xvc2VkIGJsb2NrJywgcG9zLmxpbmUsIHBvcy5jb2x1bW4pO1xuICAgIH1cblxuICAgIGRvdWJsZUNvbG9uKHRva2VuKSB7XG4gICAgICAgIHRocm93IHRoaXMuaW5wdXQuZXJyb3IoJ0RvdWJsZSBjb2xvbicsIHRva2VuWzJdLCB0b2tlblszXSk7XG4gICAgfVxuXG4gICAgdW5uYW1lZEF0cnVsZShub2RlLCB0b2tlbikge1xuICAgICAgICB0aHJvdyB0aGlzLmlucHV0LmVycm9yKCdBdC1ydWxlIHdpdGhvdXQgbmFtZScsIHRva2VuWzJdLCB0b2tlblszXSk7XG4gICAgfVxuXG4gICAgcHJlY2hlY2tNaXNzZWRTZW1pY29sb24odG9rZW5zKSB7XG4gICAgICAgIC8vIEhvb2sgZm9yIFNhZmUgUGFyc2VyXG4gICAgICAgIHRva2VucztcbiAgICB9XG5cbiAgICBjaGVja01pc3NlZFNlbWljb2xvbih0b2tlbnMpIHtcbiAgICAgICAgbGV0IGNvbG9uID0gdGhpcy5jb2xvbih0b2tlbnMpO1xuICAgICAgICBpZiAoIGNvbG9uID09PSBmYWxzZSApIHJldHVybjtcblxuICAgICAgICBsZXQgZm91bmRlZCA9IDA7XG4gICAgICAgIGxldCB0b2tlbjtcbiAgICAgICAgZm9yICggbGV0IGogPSBjb2xvbiAtIDE7IGogPj0gMDsgai0tICkge1xuICAgICAgICAgICAgdG9rZW4gPSB0b2tlbnNbal07XG4gICAgICAgICAgICBpZiAoIHRva2VuWzBdICE9PSAnc3BhY2UnICkge1xuICAgICAgICAgICAgICAgIGZvdW5kZWQgKz0gMTtcbiAgICAgICAgICAgICAgICBpZiAoIGZvdW5kZWQgPT09IDIgKSBicmVhaztcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICB0aHJvdyB0aGlzLmlucHV0LmVycm9yKCdNaXNzZWQgc2VtaWNvbG9uJywgdG9rZW5bMl0sIHRva2VuWzNdKTtcbiAgICB9XG5cbn1cbiJdfQ==
