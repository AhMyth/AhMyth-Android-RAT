'use strict';

exports.__esModule = true;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var defaultRaw = {
    colon: ': ',
    indent: '    ',
    beforeDecl: '\n',
    beforeRule: '\n',
    beforeOpen: ' ',
    beforeClose: '\n',
    beforeComment: '\n',
    after: '\n',
    emptyBody: '',
    commentLeft: ' ',
    commentRight: ' '
};

function capitalize(str) {
    return str[0].toUpperCase() + str.slice(1);
}

var Stringifier = function () {
    function Stringifier(builder) {
        _classCallCheck(this, Stringifier);

        this.builder = builder;
    }

    Stringifier.prototype.stringify = function stringify(node, semicolon) {
        this[node.type](node, semicolon);
    };

    Stringifier.prototype.root = function root(node) {
        this.body(node);
        if (node.raws.after) this.builder(node.raws.after);
    };

    Stringifier.prototype.comment = function comment(node) {
        var left = this.raw(node, 'left', 'commentLeft');
        var right = this.raw(node, 'right', 'commentRight');
        this.builder('/*' + left + node.text + right + '*/', node);
    };

    Stringifier.prototype.decl = function decl(node, semicolon) {
        var between = this.raw(node, 'between', 'colon');
        var string = node.prop + between + this.rawValue(node, 'value');

        if (node.important) {
            string += node.raws.important || ' !important';
        }

        if (semicolon) string += ';';
        this.builder(string, node);
    };

    Stringifier.prototype.rule = function rule(node) {
        this.block(node, this.rawValue(node, 'selector'));
    };

    Stringifier.prototype.atrule = function atrule(node, semicolon) {
        var name = '@' + node.name;
        var params = node.params ? this.rawValue(node, 'params') : '';

        if (typeof node.raws.afterName !== 'undefined') {
            name += node.raws.afterName;
        } else if (params) {
            name += ' ';
        }

        if (node.nodes) {
            this.block(node, name + params);
        } else {
            var end = (node.raws.between || '') + (semicolon ? ';' : '');
            this.builder(name + params + end, node);
        }
    };

    Stringifier.prototype.body = function body(node) {
        var last = node.nodes.length - 1;
        while (last > 0) {
            if (node.nodes[last].type !== 'comment') break;
            last -= 1;
        }

        var semicolon = this.raw(node, 'semicolon');
        for (var i = 0; i < node.nodes.length; i++) {
            var child = node.nodes[i];
            var before = this.raw(child, 'before');
            if (before) this.builder(before);
            this.stringify(child, last !== i || semicolon);
        }
    };

    Stringifier.prototype.block = function block(node, start) {
        var between = this.raw(node, 'between', 'beforeOpen');
        this.builder(start + between + '{', node, 'start');

        var after = void 0;
        if (node.nodes && node.nodes.length) {
            this.body(node);
            after = this.raw(node, 'after');
        } else {
            after = this.raw(node, 'after', 'emptyBody');
        }

        if (after) this.builder(after);
        this.builder('}', node, 'end');
    };

    Stringifier.prototype.raw = function raw(node, own, detect) {
        var value = void 0;
        if (!detect) detect = own;

        // Already had
        if (own) {
            value = node.raws[own];
            if (typeof value !== 'undefined') return value;
        }

        var parent = node.parent;

        // Hack for first rule in CSS
        if (detect === 'before') {
            if (!parent || parent.type === 'root' && parent.first === node) {
                return '';
            }
        }

        // Floating child without parent
        if (!parent) return defaultRaw[detect];

        // Detect style by other nodes
        var root = node.root();
        if (!root.rawCache) root.rawCache = {};
        if (typeof root.rawCache[detect] !== 'undefined') {
            return root.rawCache[detect];
        }

        if (detect === 'before' || detect === 'after') {
            return this.beforeAfter(node, detect);
        } else {
            var method = 'raw' + capitalize(detect);
            if (this[method]) {
                value = this[method](root, node);
            } else {
                root.walk(function (i) {
                    value = i.raws[own];
                    if (typeof value !== 'undefined') return false;
                });
            }
        }

        if (typeof value === 'undefined') value = defaultRaw[detect];

        root.rawCache[detect] = value;
        return value;
    };

    Stringifier.prototype.rawSemicolon = function rawSemicolon(root) {
        var value = void 0;
        root.walk(function (i) {
            if (i.nodes && i.nodes.length && i.last.type === 'decl') {
                value = i.raws.semicolon;
                if (typeof value !== 'undefined') return false;
            }
        });
        return value;
    };

    Stringifier.prototype.rawEmptyBody = function rawEmptyBody(root) {
        var value = void 0;
        root.walk(function (i) {
            if (i.nodes && i.nodes.length === 0) {
                value = i.raws.after;
                if (typeof value !== 'undefined') return false;
            }
        });
        return value;
    };

    Stringifier.prototype.rawIndent = function rawIndent(root) {
        if (root.raws.indent) return root.raws.indent;
        var value = void 0;
        root.walk(function (i) {
            var p = i.parent;
            if (p && p !== root && p.parent && p.parent === root) {
                if (typeof i.raws.before !== 'undefined') {
                    var parts = i.raws.before.split('\n');
                    value = parts[parts.length - 1];
                    value = value.replace(/[^\s]/g, '');
                    return false;
                }
            }
        });
        return value;
    };

    Stringifier.prototype.rawBeforeComment = function rawBeforeComment(root, node) {
        var value = void 0;
        root.walkComments(function (i) {
            if (typeof i.raws.before !== 'undefined') {
                value = i.raws.before;
                if (value.indexOf('\n') !== -1) {
                    value = value.replace(/[^\n]+$/, '');
                }
                return false;
            }
        });
        if (typeof value === 'undefined') {
            value = this.raw(node, null, 'beforeDecl');
        }
        return value;
    };

    Stringifier.prototype.rawBeforeDecl = function rawBeforeDecl(root, node) {
        var value = void 0;
        root.walkDecls(function (i) {
            if (typeof i.raws.before !== 'undefined') {
                value = i.raws.before;
                if (value.indexOf('\n') !== -1) {
                    value = value.replace(/[^\n]+$/, '');
                }
                return false;
            }
        });
        if (typeof value === 'undefined') {
            value = this.raw(node, null, 'beforeRule');
        }
        return value;
    };

    Stringifier.prototype.rawBeforeRule = function rawBeforeRule(root) {
        var value = void 0;
        root.walk(function (i) {
            if (i.nodes && (i.parent !== root || root.first !== i)) {
                if (typeof i.raws.before !== 'undefined') {
                    value = i.raws.before;
                    if (value.indexOf('\n') !== -1) {
                        value = value.replace(/[^\n]+$/, '');
                    }
                    return false;
                }
            }
        });
        return value;
    };

    Stringifier.prototype.rawBeforeClose = function rawBeforeClose(root) {
        var value = void 0;
        root.walk(function (i) {
            if (i.nodes && i.nodes.length > 0) {
                if (typeof i.raws.after !== 'undefined') {
                    value = i.raws.after;
                    if (value.indexOf('\n') !== -1) {
                        value = value.replace(/[^\n]+$/, '');
                    }
                    return false;
                }
            }
        });
        return value;
    };

    Stringifier.prototype.rawBeforeOpen = function rawBeforeOpen(root) {
        var value = void 0;
        root.walk(function (i) {
            if (i.type !== 'decl') {
                value = i.raws.between;
                if (typeof value !== 'undefined') return false;
            }
        });
        return value;
    };

    Stringifier.prototype.rawColon = function rawColon(root) {
        var value = void 0;
        root.walkDecls(function (i) {
            if (typeof i.raws.between !== 'undefined') {
                value = i.raws.between.replace(/[^\s:]/g, '');
                return false;
            }
        });
        return value;
    };

    Stringifier.prototype.beforeAfter = function beforeAfter(node, detect) {
        var value = void 0;
        if (node.type === 'decl') {
            value = this.raw(node, null, 'beforeDecl');
        } else if (node.type === 'comment') {
            value = this.raw(node, null, 'beforeComment');
        } else if (detect === 'before') {
            value = this.raw(node, null, 'beforeRule');
        } else {
            value = this.raw(node, null, 'beforeClose');
        }

        var buf = node.parent;
        var depth = 0;
        while (buf && buf.type !== 'root') {
            depth += 1;
            buf = buf.parent;
        }

        if (value.indexOf('\n') !== -1) {
            var indent = this.raw(node, null, 'indent');
            if (indent.length) {
                for (var step = 0; step < depth; step++) {
                    value += indent;
                }
            }
        }

        return value;
    };

    Stringifier.prototype.rawValue = function rawValue(node, prop) {
        var value = node[prop];
        var raw = node.raws[prop];
        if (raw && raw.value === value) {
            return raw.raw;
        } else {
            return value;
        }
    };

    return Stringifier;
}();

exports.default = Stringifier;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvc3RyaW5naWZpZXIuZXM2Il0sIm5hbWVzIjpbImRlZmF1bHRSYXciLCJjb2xvbiIsImluZGVudCIsImJlZm9yZURlY2wiLCJiZWZvcmVSdWxlIiwiYmVmb3JlT3BlbiIsImJlZm9yZUNsb3NlIiwiYmVmb3JlQ29tbWVudCIsImFmdGVyIiwiZW1wdHlCb2R5IiwiY29tbWVudExlZnQiLCJjb21tZW50UmlnaHQiLCJjYXBpdGFsaXplIiwic3RyIiwidG9VcHBlckNhc2UiLCJzbGljZSIsIlN0cmluZ2lmaWVyIiwiYnVpbGRlciIsInN0cmluZ2lmeSIsIm5vZGUiLCJzZW1pY29sb24iLCJ0eXBlIiwicm9vdCIsImJvZHkiLCJyYXdzIiwiY29tbWVudCIsImxlZnQiLCJyYXciLCJyaWdodCIsInRleHQiLCJkZWNsIiwiYmV0d2VlbiIsInN0cmluZyIsInByb3AiLCJyYXdWYWx1ZSIsImltcG9ydGFudCIsInJ1bGUiLCJibG9jayIsImF0cnVsZSIsIm5hbWUiLCJwYXJhbXMiLCJhZnRlck5hbWUiLCJub2RlcyIsImVuZCIsImxhc3QiLCJsZW5ndGgiLCJpIiwiY2hpbGQiLCJiZWZvcmUiLCJzdGFydCIsIm93biIsImRldGVjdCIsInZhbHVlIiwicGFyZW50IiwiZmlyc3QiLCJyYXdDYWNoZSIsImJlZm9yZUFmdGVyIiwibWV0aG9kIiwid2FsayIsInJhd1NlbWljb2xvbiIsInJhd0VtcHR5Qm9keSIsInJhd0luZGVudCIsInAiLCJwYXJ0cyIsInNwbGl0IiwicmVwbGFjZSIsInJhd0JlZm9yZUNvbW1lbnQiLCJ3YWxrQ29tbWVudHMiLCJpbmRleE9mIiwicmF3QmVmb3JlRGVjbCIsIndhbGtEZWNscyIsInJhd0JlZm9yZVJ1bGUiLCJyYXdCZWZvcmVDbG9zZSIsInJhd0JlZm9yZU9wZW4iLCJyYXdDb2xvbiIsImJ1ZiIsImRlcHRoIiwic3RlcCJdLCJtYXBwaW5ncyI6Ijs7Ozs7O0FBQUEsSUFBTUEsYUFBYTtBQUNmQyxXQUFlLElBREE7QUFFZkMsWUFBZSxNQUZBO0FBR2ZDLGdCQUFlLElBSEE7QUFJZkMsZ0JBQWUsSUFKQTtBQUtmQyxnQkFBZSxHQUxBO0FBTWZDLGlCQUFlLElBTkE7QUFPZkMsbUJBQWUsSUFQQTtBQVFmQyxXQUFlLElBUkE7QUFTZkMsZUFBZSxFQVRBO0FBVWZDLGlCQUFlLEdBVkE7QUFXZkMsa0JBQWU7QUFYQSxDQUFuQjs7QUFjQSxTQUFTQyxVQUFULENBQW9CQyxHQUFwQixFQUF5QjtBQUNyQixXQUFPQSxJQUFJLENBQUosRUFBT0MsV0FBUCxLQUF1QkQsSUFBSUUsS0FBSixDQUFVLENBQVYsQ0FBOUI7QUFDSDs7SUFFS0MsVztBQUVGLHlCQUFZQyxPQUFaLEVBQXFCO0FBQUE7O0FBQ2pCLGFBQUtBLE9BQUwsR0FBZUEsT0FBZjtBQUNIOzswQkFFREMsUyxzQkFBVUMsSSxFQUFNQyxTLEVBQVc7QUFDdkIsYUFBS0QsS0FBS0UsSUFBVixFQUFnQkYsSUFBaEIsRUFBc0JDLFNBQXRCO0FBQ0gsSzs7MEJBRURFLEksaUJBQUtILEksRUFBTTtBQUNQLGFBQUtJLElBQUwsQ0FBVUosSUFBVjtBQUNBLFlBQUtBLEtBQUtLLElBQUwsQ0FBVWhCLEtBQWYsRUFBdUIsS0FBS1MsT0FBTCxDQUFhRSxLQUFLSyxJQUFMLENBQVVoQixLQUF2QjtBQUMxQixLOzswQkFFRGlCLE8sb0JBQVFOLEksRUFBTTtBQUNWLFlBQUlPLE9BQVEsS0FBS0MsR0FBTCxDQUFTUixJQUFULEVBQWUsTUFBZixFQUF3QixhQUF4QixDQUFaO0FBQ0EsWUFBSVMsUUFBUSxLQUFLRCxHQUFMLENBQVNSLElBQVQsRUFBZSxPQUFmLEVBQXdCLGNBQXhCLENBQVo7QUFDQSxhQUFLRixPQUFMLENBQWEsT0FBT1MsSUFBUCxHQUFjUCxLQUFLVSxJQUFuQixHQUEwQkQsS0FBMUIsR0FBa0MsSUFBL0MsRUFBcURULElBQXJEO0FBQ0gsSzs7MEJBRURXLEksaUJBQUtYLEksRUFBTUMsUyxFQUFXO0FBQ2xCLFlBQUlXLFVBQVUsS0FBS0osR0FBTCxDQUFTUixJQUFULEVBQWUsU0FBZixFQUEwQixPQUExQixDQUFkO0FBQ0EsWUFBSWEsU0FBVWIsS0FBS2MsSUFBTCxHQUFZRixPQUFaLEdBQXNCLEtBQUtHLFFBQUwsQ0FBY2YsSUFBZCxFQUFvQixPQUFwQixDQUFwQzs7QUFFQSxZQUFLQSxLQUFLZ0IsU0FBVixFQUFzQjtBQUNsQkgsc0JBQVViLEtBQUtLLElBQUwsQ0FBVVcsU0FBVixJQUF1QixhQUFqQztBQUNIOztBQUVELFlBQUtmLFNBQUwsRUFBaUJZLFVBQVUsR0FBVjtBQUNqQixhQUFLZixPQUFMLENBQWFlLE1BQWIsRUFBcUJiLElBQXJCO0FBQ0gsSzs7MEJBRURpQixJLGlCQUFLakIsSSxFQUFNO0FBQ1AsYUFBS2tCLEtBQUwsQ0FBV2xCLElBQVgsRUFBaUIsS0FBS2UsUUFBTCxDQUFjZixJQUFkLEVBQW9CLFVBQXBCLENBQWpCO0FBQ0gsSzs7MEJBRURtQixNLG1CQUFPbkIsSSxFQUFNQyxTLEVBQVc7QUFDcEIsWUFBSW1CLE9BQVMsTUFBTXBCLEtBQUtvQixJQUF4QjtBQUNBLFlBQUlDLFNBQVNyQixLQUFLcUIsTUFBTCxHQUFjLEtBQUtOLFFBQUwsQ0FBY2YsSUFBZCxFQUFvQixRQUFwQixDQUFkLEdBQThDLEVBQTNEOztBQUVBLFlBQUssT0FBT0EsS0FBS0ssSUFBTCxDQUFVaUIsU0FBakIsS0FBK0IsV0FBcEMsRUFBa0Q7QUFDOUNGLG9CQUFRcEIsS0FBS0ssSUFBTCxDQUFVaUIsU0FBbEI7QUFDSCxTQUZELE1BRU8sSUFBS0QsTUFBTCxFQUFjO0FBQ2pCRCxvQkFBUSxHQUFSO0FBQ0g7O0FBRUQsWUFBS3BCLEtBQUt1QixLQUFWLEVBQWtCO0FBQ2QsaUJBQUtMLEtBQUwsQ0FBV2xCLElBQVgsRUFBaUJvQixPQUFPQyxNQUF4QjtBQUNILFNBRkQsTUFFTztBQUNILGdCQUFJRyxNQUFNLENBQUN4QixLQUFLSyxJQUFMLENBQVVPLE9BQVYsSUFBcUIsRUFBdEIsS0FBNkJYLFlBQVksR0FBWixHQUFrQixFQUEvQyxDQUFWO0FBQ0EsaUJBQUtILE9BQUwsQ0FBYXNCLE9BQU9DLE1BQVAsR0FBZ0JHLEdBQTdCLEVBQWtDeEIsSUFBbEM7QUFDSDtBQUNKLEs7OzBCQUVESSxJLGlCQUFLSixJLEVBQU07QUFDUCxZQUFJeUIsT0FBT3pCLEtBQUt1QixLQUFMLENBQVdHLE1BQVgsR0FBb0IsQ0FBL0I7QUFDQSxlQUFRRCxPQUFPLENBQWYsRUFBbUI7QUFDZixnQkFBS3pCLEtBQUt1QixLQUFMLENBQVdFLElBQVgsRUFBaUJ2QixJQUFqQixLQUEwQixTQUEvQixFQUEyQztBQUMzQ3VCLG9CQUFRLENBQVI7QUFDSDs7QUFFRCxZQUFJeEIsWUFBWSxLQUFLTyxHQUFMLENBQVNSLElBQVQsRUFBZSxXQUFmLENBQWhCO0FBQ0EsYUFBTSxJQUFJMkIsSUFBSSxDQUFkLEVBQWlCQSxJQUFJM0IsS0FBS3VCLEtBQUwsQ0FBV0csTUFBaEMsRUFBd0NDLEdBQXhDLEVBQThDO0FBQzFDLGdCQUFJQyxRQUFTNUIsS0FBS3VCLEtBQUwsQ0FBV0ksQ0FBWCxDQUFiO0FBQ0EsZ0JBQUlFLFNBQVMsS0FBS3JCLEdBQUwsQ0FBU29CLEtBQVQsRUFBZ0IsUUFBaEIsQ0FBYjtBQUNBLGdCQUFLQyxNQUFMLEVBQWMsS0FBSy9CLE9BQUwsQ0FBYStCLE1BQWI7QUFDZCxpQkFBSzlCLFNBQUwsQ0FBZTZCLEtBQWYsRUFBc0JILFNBQVNFLENBQVQsSUFBYzFCLFNBQXBDO0FBQ0g7QUFDSixLOzswQkFFRGlCLEssa0JBQU1sQixJLEVBQU04QixLLEVBQU87QUFDZixZQUFJbEIsVUFBVSxLQUFLSixHQUFMLENBQVNSLElBQVQsRUFBZSxTQUFmLEVBQTBCLFlBQTFCLENBQWQ7QUFDQSxhQUFLRixPQUFMLENBQWFnQyxRQUFRbEIsT0FBUixHQUFrQixHQUEvQixFQUFvQ1osSUFBcEMsRUFBMEMsT0FBMUM7O0FBRUEsWUFBSVgsY0FBSjtBQUNBLFlBQUtXLEtBQUt1QixLQUFMLElBQWN2QixLQUFLdUIsS0FBTCxDQUFXRyxNQUE5QixFQUF1QztBQUNuQyxpQkFBS3RCLElBQUwsQ0FBVUosSUFBVjtBQUNBWCxvQkFBUSxLQUFLbUIsR0FBTCxDQUFTUixJQUFULEVBQWUsT0FBZixDQUFSO0FBQ0gsU0FIRCxNQUdPO0FBQ0hYLG9CQUFRLEtBQUttQixHQUFMLENBQVNSLElBQVQsRUFBZSxPQUFmLEVBQXdCLFdBQXhCLENBQVI7QUFDSDs7QUFFRCxZQUFLWCxLQUFMLEVBQWEsS0FBS1MsT0FBTCxDQUFhVCxLQUFiO0FBQ2IsYUFBS1MsT0FBTCxDQUFhLEdBQWIsRUFBa0JFLElBQWxCLEVBQXdCLEtBQXhCO0FBQ0gsSzs7MEJBRURRLEcsZ0JBQUlSLEksRUFBTStCLEcsRUFBS0MsTSxFQUFRO0FBQ25CLFlBQUlDLGNBQUo7QUFDQSxZQUFLLENBQUNELE1BQU4sRUFBZUEsU0FBU0QsR0FBVDs7QUFFZjtBQUNBLFlBQUtBLEdBQUwsRUFBVztBQUNQRSxvQkFBUWpDLEtBQUtLLElBQUwsQ0FBVTBCLEdBQVYsQ0FBUjtBQUNBLGdCQUFLLE9BQU9FLEtBQVAsS0FBaUIsV0FBdEIsRUFBb0MsT0FBT0EsS0FBUDtBQUN2Qzs7QUFFRCxZQUFJQyxTQUFTbEMsS0FBS2tDLE1BQWxCOztBQUVBO0FBQ0EsWUFBS0YsV0FBVyxRQUFoQixFQUEyQjtBQUN2QixnQkFBSyxDQUFDRSxNQUFELElBQVdBLE9BQU9oQyxJQUFQLEtBQWdCLE1BQWhCLElBQTBCZ0MsT0FBT0MsS0FBUCxLQUFpQm5DLElBQTNELEVBQWtFO0FBQzlELHVCQUFPLEVBQVA7QUFDSDtBQUNKOztBQUVEO0FBQ0EsWUFBSyxDQUFDa0MsTUFBTixFQUFlLE9BQU9yRCxXQUFXbUQsTUFBWCxDQUFQOztBQUVmO0FBQ0EsWUFBSTdCLE9BQU9ILEtBQUtHLElBQUwsRUFBWDtBQUNBLFlBQUssQ0FBQ0EsS0FBS2lDLFFBQVgsRUFBc0JqQyxLQUFLaUMsUUFBTCxHQUFnQixFQUFoQjtBQUN0QixZQUFLLE9BQU9qQyxLQUFLaUMsUUFBTCxDQUFjSixNQUFkLENBQVAsS0FBaUMsV0FBdEMsRUFBb0Q7QUFDaEQsbUJBQU83QixLQUFLaUMsUUFBTCxDQUFjSixNQUFkLENBQVA7QUFDSDs7QUFFRCxZQUFLQSxXQUFXLFFBQVgsSUFBdUJBLFdBQVcsT0FBdkMsRUFBaUQ7QUFDN0MsbUJBQU8sS0FBS0ssV0FBTCxDQUFpQnJDLElBQWpCLEVBQXVCZ0MsTUFBdkIsQ0FBUDtBQUNILFNBRkQsTUFFTztBQUNILGdCQUFJTSxTQUFTLFFBQVE3QyxXQUFXdUMsTUFBWCxDQUFyQjtBQUNBLGdCQUFLLEtBQUtNLE1BQUwsQ0FBTCxFQUFvQjtBQUNoQkwsd0JBQVEsS0FBS0ssTUFBTCxFQUFhbkMsSUFBYixFQUFtQkgsSUFBbkIsQ0FBUjtBQUNILGFBRkQsTUFFTztBQUNIRyxxQkFBS29DLElBQUwsQ0FBVyxhQUFLO0FBQ1pOLDRCQUFRTixFQUFFdEIsSUFBRixDQUFPMEIsR0FBUCxDQUFSO0FBQ0Esd0JBQUssT0FBT0UsS0FBUCxLQUFpQixXQUF0QixFQUFvQyxPQUFPLEtBQVA7QUFDdkMsaUJBSEQ7QUFJSDtBQUNKOztBQUVELFlBQUssT0FBT0EsS0FBUCxLQUFpQixXQUF0QixFQUFvQ0EsUUFBUXBELFdBQVdtRCxNQUFYLENBQVI7O0FBRXBDN0IsYUFBS2lDLFFBQUwsQ0FBY0osTUFBZCxJQUF3QkMsS0FBeEI7QUFDQSxlQUFPQSxLQUFQO0FBQ0gsSzs7MEJBRURPLFkseUJBQWFyQyxJLEVBQU07QUFDZixZQUFJOEIsY0FBSjtBQUNBOUIsYUFBS29DLElBQUwsQ0FBVyxhQUFLO0FBQ1osZ0JBQUtaLEVBQUVKLEtBQUYsSUFBV0ksRUFBRUosS0FBRixDQUFRRyxNQUFuQixJQUE2QkMsRUFBRUYsSUFBRixDQUFPdkIsSUFBUCxLQUFnQixNQUFsRCxFQUEyRDtBQUN2RCtCLHdCQUFRTixFQUFFdEIsSUFBRixDQUFPSixTQUFmO0FBQ0Esb0JBQUssT0FBT2dDLEtBQVAsS0FBaUIsV0FBdEIsRUFBb0MsT0FBTyxLQUFQO0FBQ3ZDO0FBQ0osU0FMRDtBQU1BLGVBQU9BLEtBQVA7QUFDSCxLOzswQkFFRFEsWSx5QkFBYXRDLEksRUFBTTtBQUNmLFlBQUk4QixjQUFKO0FBQ0E5QixhQUFLb0MsSUFBTCxDQUFXLGFBQUs7QUFDWixnQkFBS1osRUFBRUosS0FBRixJQUFXSSxFQUFFSixLQUFGLENBQVFHLE1BQVIsS0FBbUIsQ0FBbkMsRUFBdUM7QUFDbkNPLHdCQUFRTixFQUFFdEIsSUFBRixDQUFPaEIsS0FBZjtBQUNBLG9CQUFLLE9BQU80QyxLQUFQLEtBQWlCLFdBQXRCLEVBQW9DLE9BQU8sS0FBUDtBQUN2QztBQUNKLFNBTEQ7QUFNQSxlQUFPQSxLQUFQO0FBQ0gsSzs7MEJBRURTLFMsc0JBQVV2QyxJLEVBQU07QUFDWixZQUFLQSxLQUFLRSxJQUFMLENBQVV0QixNQUFmLEVBQXdCLE9BQU9vQixLQUFLRSxJQUFMLENBQVV0QixNQUFqQjtBQUN4QixZQUFJa0QsY0FBSjtBQUNBOUIsYUFBS29DLElBQUwsQ0FBVyxhQUFLO0FBQ1osZ0JBQUlJLElBQUloQixFQUFFTyxNQUFWO0FBQ0EsZ0JBQUtTLEtBQUtBLE1BQU14QyxJQUFYLElBQW1Cd0MsRUFBRVQsTUFBckIsSUFBK0JTLEVBQUVULE1BQUYsS0FBYS9CLElBQWpELEVBQXdEO0FBQ3BELG9CQUFLLE9BQU93QixFQUFFdEIsSUFBRixDQUFPd0IsTUFBZCxLQUF5QixXQUE5QixFQUE0QztBQUN4Qyx3QkFBSWUsUUFBUWpCLEVBQUV0QixJQUFGLENBQU93QixNQUFQLENBQWNnQixLQUFkLENBQW9CLElBQXBCLENBQVo7QUFDQVosNEJBQVFXLE1BQU1BLE1BQU1sQixNQUFOLEdBQWUsQ0FBckIsQ0FBUjtBQUNBTyw0QkFBUUEsTUFBTWEsT0FBTixDQUFjLFFBQWQsRUFBd0IsRUFBeEIsQ0FBUjtBQUNBLDJCQUFPLEtBQVA7QUFDSDtBQUNKO0FBQ0osU0FWRDtBQVdBLGVBQU9iLEtBQVA7QUFDSCxLOzswQkFFRGMsZ0IsNkJBQWlCNUMsSSxFQUFNSCxJLEVBQU07QUFDekIsWUFBSWlDLGNBQUo7QUFDQTlCLGFBQUs2QyxZQUFMLENBQW1CLGFBQUs7QUFDcEIsZ0JBQUssT0FBT3JCLEVBQUV0QixJQUFGLENBQU93QixNQUFkLEtBQXlCLFdBQTlCLEVBQTRDO0FBQ3hDSSx3QkFBUU4sRUFBRXRCLElBQUYsQ0FBT3dCLE1BQWY7QUFDQSxvQkFBS0ksTUFBTWdCLE9BQU4sQ0FBYyxJQUFkLE1BQXdCLENBQUMsQ0FBOUIsRUFBa0M7QUFDOUJoQiw0QkFBUUEsTUFBTWEsT0FBTixDQUFjLFNBQWQsRUFBeUIsRUFBekIsQ0FBUjtBQUNIO0FBQ0QsdUJBQU8sS0FBUDtBQUNIO0FBQ0osU0FSRDtBQVNBLFlBQUssT0FBT2IsS0FBUCxLQUFpQixXQUF0QixFQUFvQztBQUNoQ0Esb0JBQVEsS0FBS3pCLEdBQUwsQ0FBU1IsSUFBVCxFQUFlLElBQWYsRUFBcUIsWUFBckIsQ0FBUjtBQUNIO0FBQ0QsZUFBT2lDLEtBQVA7QUFDSCxLOzswQkFFRGlCLGEsMEJBQWMvQyxJLEVBQU1ILEksRUFBTTtBQUN0QixZQUFJaUMsY0FBSjtBQUNBOUIsYUFBS2dELFNBQUwsQ0FBZ0IsYUFBSztBQUNqQixnQkFBSyxPQUFPeEIsRUFBRXRCLElBQUYsQ0FBT3dCLE1BQWQsS0FBeUIsV0FBOUIsRUFBNEM7QUFDeENJLHdCQUFRTixFQUFFdEIsSUFBRixDQUFPd0IsTUFBZjtBQUNBLG9CQUFLSSxNQUFNZ0IsT0FBTixDQUFjLElBQWQsTUFBd0IsQ0FBQyxDQUE5QixFQUFrQztBQUM5QmhCLDRCQUFRQSxNQUFNYSxPQUFOLENBQWMsU0FBZCxFQUF5QixFQUF6QixDQUFSO0FBQ0g7QUFDRCx1QkFBTyxLQUFQO0FBQ0g7QUFDSixTQVJEO0FBU0EsWUFBSyxPQUFPYixLQUFQLEtBQWlCLFdBQXRCLEVBQW9DO0FBQ2hDQSxvQkFBUSxLQUFLekIsR0FBTCxDQUFTUixJQUFULEVBQWUsSUFBZixFQUFxQixZQUFyQixDQUFSO0FBQ0g7QUFDRCxlQUFPaUMsS0FBUDtBQUNILEs7OzBCQUVEbUIsYSwwQkFBY2pELEksRUFBTTtBQUNoQixZQUFJOEIsY0FBSjtBQUNBOUIsYUFBS29DLElBQUwsQ0FBVyxhQUFLO0FBQ1osZ0JBQUtaLEVBQUVKLEtBQUYsS0FBWUksRUFBRU8sTUFBRixLQUFhL0IsSUFBYixJQUFxQkEsS0FBS2dDLEtBQUwsS0FBZVIsQ0FBaEQsQ0FBTCxFQUEwRDtBQUN0RCxvQkFBSyxPQUFPQSxFQUFFdEIsSUFBRixDQUFPd0IsTUFBZCxLQUF5QixXQUE5QixFQUE0QztBQUN4Q0ksNEJBQVFOLEVBQUV0QixJQUFGLENBQU93QixNQUFmO0FBQ0Esd0JBQUtJLE1BQU1nQixPQUFOLENBQWMsSUFBZCxNQUF3QixDQUFDLENBQTlCLEVBQWtDO0FBQzlCaEIsZ0NBQVFBLE1BQU1hLE9BQU4sQ0FBYyxTQUFkLEVBQXlCLEVBQXpCLENBQVI7QUFDSDtBQUNELDJCQUFPLEtBQVA7QUFDSDtBQUNKO0FBQ0osU0FWRDtBQVdBLGVBQU9iLEtBQVA7QUFDSCxLOzswQkFFRG9CLGMsMkJBQWVsRCxJLEVBQU07QUFDakIsWUFBSThCLGNBQUo7QUFDQTlCLGFBQUtvQyxJQUFMLENBQVcsYUFBSztBQUNaLGdCQUFLWixFQUFFSixLQUFGLElBQVdJLEVBQUVKLEtBQUYsQ0FBUUcsTUFBUixHQUFpQixDQUFqQyxFQUFxQztBQUNqQyxvQkFBSyxPQUFPQyxFQUFFdEIsSUFBRixDQUFPaEIsS0FBZCxLQUF3QixXQUE3QixFQUEyQztBQUN2QzRDLDRCQUFRTixFQUFFdEIsSUFBRixDQUFPaEIsS0FBZjtBQUNBLHdCQUFLNEMsTUFBTWdCLE9BQU4sQ0FBYyxJQUFkLE1BQXdCLENBQUMsQ0FBOUIsRUFBa0M7QUFDOUJoQixnQ0FBUUEsTUFBTWEsT0FBTixDQUFjLFNBQWQsRUFBeUIsRUFBekIsQ0FBUjtBQUNIO0FBQ0QsMkJBQU8sS0FBUDtBQUNIO0FBQ0o7QUFDSixTQVZEO0FBV0EsZUFBT2IsS0FBUDtBQUNILEs7OzBCQUVEcUIsYSwwQkFBY25ELEksRUFBTTtBQUNoQixZQUFJOEIsY0FBSjtBQUNBOUIsYUFBS29DLElBQUwsQ0FBVyxhQUFLO0FBQ1osZ0JBQUtaLEVBQUV6QixJQUFGLEtBQVcsTUFBaEIsRUFBeUI7QUFDckIrQix3QkFBUU4sRUFBRXRCLElBQUYsQ0FBT08sT0FBZjtBQUNBLG9CQUFLLE9BQU9xQixLQUFQLEtBQWlCLFdBQXRCLEVBQW9DLE9BQU8sS0FBUDtBQUN2QztBQUNKLFNBTEQ7QUFNQSxlQUFPQSxLQUFQO0FBQ0gsSzs7MEJBRURzQixRLHFCQUFTcEQsSSxFQUFNO0FBQ1gsWUFBSThCLGNBQUo7QUFDQTlCLGFBQUtnRCxTQUFMLENBQWdCLGFBQUs7QUFDakIsZ0JBQUssT0FBT3hCLEVBQUV0QixJQUFGLENBQU9PLE9BQWQsS0FBMEIsV0FBL0IsRUFBNkM7QUFDekNxQix3QkFBUU4sRUFBRXRCLElBQUYsQ0FBT08sT0FBUCxDQUFla0MsT0FBZixDQUF1QixTQUF2QixFQUFrQyxFQUFsQyxDQUFSO0FBQ0EsdUJBQU8sS0FBUDtBQUNIO0FBQ0osU0FMRDtBQU1BLGVBQU9iLEtBQVA7QUFDSCxLOzswQkFFREksVyx3QkFBWXJDLEksRUFBTWdDLE0sRUFBUTtBQUN0QixZQUFJQyxjQUFKO0FBQ0EsWUFBS2pDLEtBQUtFLElBQUwsS0FBYyxNQUFuQixFQUE0QjtBQUN4QitCLG9CQUFRLEtBQUt6QixHQUFMLENBQVNSLElBQVQsRUFBZSxJQUFmLEVBQXFCLFlBQXJCLENBQVI7QUFDSCxTQUZELE1BRU8sSUFBS0EsS0FBS0UsSUFBTCxLQUFjLFNBQW5CLEVBQStCO0FBQ2xDK0Isb0JBQVEsS0FBS3pCLEdBQUwsQ0FBU1IsSUFBVCxFQUFlLElBQWYsRUFBcUIsZUFBckIsQ0FBUjtBQUNILFNBRk0sTUFFQSxJQUFLZ0MsV0FBVyxRQUFoQixFQUEyQjtBQUM5QkMsb0JBQVEsS0FBS3pCLEdBQUwsQ0FBU1IsSUFBVCxFQUFlLElBQWYsRUFBcUIsWUFBckIsQ0FBUjtBQUNILFNBRk0sTUFFQTtBQUNIaUMsb0JBQVEsS0FBS3pCLEdBQUwsQ0FBU1IsSUFBVCxFQUFlLElBQWYsRUFBcUIsYUFBckIsQ0FBUjtBQUNIOztBQUVELFlBQUl3RCxNQUFReEQsS0FBS2tDLE1BQWpCO0FBQ0EsWUFBSXVCLFFBQVEsQ0FBWjtBQUNBLGVBQVFELE9BQU9BLElBQUl0RCxJQUFKLEtBQWEsTUFBNUIsRUFBcUM7QUFDakN1RCxxQkFBUyxDQUFUO0FBQ0FELGtCQUFNQSxJQUFJdEIsTUFBVjtBQUNIOztBQUVELFlBQUtELE1BQU1nQixPQUFOLENBQWMsSUFBZCxNQUF3QixDQUFDLENBQTlCLEVBQWtDO0FBQzlCLGdCQUFJbEUsU0FBUyxLQUFLeUIsR0FBTCxDQUFTUixJQUFULEVBQWUsSUFBZixFQUFxQixRQUFyQixDQUFiO0FBQ0EsZ0JBQUtqQixPQUFPMkMsTUFBWixFQUFxQjtBQUNqQixxQkFBTSxJQUFJZ0MsT0FBTyxDQUFqQixFQUFvQkEsT0FBT0QsS0FBM0IsRUFBa0NDLE1BQWxDO0FBQTJDekIsNkJBQVNsRCxNQUFUO0FBQTNDO0FBQ0g7QUFDSjs7QUFFRCxlQUFPa0QsS0FBUDtBQUNILEs7OzBCQUVEbEIsUSxxQkFBU2YsSSxFQUFNYyxJLEVBQU07QUFDakIsWUFBSW1CLFFBQVFqQyxLQUFLYyxJQUFMLENBQVo7QUFDQSxZQUFJTixNQUFRUixLQUFLSyxJQUFMLENBQVVTLElBQVYsQ0FBWjtBQUNBLFlBQUtOLE9BQU9BLElBQUl5QixLQUFKLEtBQWNBLEtBQTFCLEVBQWtDO0FBQzlCLG1CQUFPekIsSUFBSUEsR0FBWDtBQUNILFNBRkQsTUFFTztBQUNILG1CQUFPeUIsS0FBUDtBQUNIO0FBQ0osSzs7Ozs7a0JBSVVwQyxXIiwiZmlsZSI6InN0cmluZ2lmaWVyLmpzIiwic291cmNlc0NvbnRlbnQiOlsiY29uc3QgZGVmYXVsdFJhdyA9IHtcbiAgICBjb2xvbjogICAgICAgICAnOiAnLFxuICAgIGluZGVudDogICAgICAgICcgICAgJyxcbiAgICBiZWZvcmVEZWNsOiAgICAnXFxuJyxcbiAgICBiZWZvcmVSdWxlOiAgICAnXFxuJyxcbiAgICBiZWZvcmVPcGVuOiAgICAnICcsXG4gICAgYmVmb3JlQ2xvc2U6ICAgJ1xcbicsXG4gICAgYmVmb3JlQ29tbWVudDogJ1xcbicsXG4gICAgYWZ0ZXI6ICAgICAgICAgJ1xcbicsXG4gICAgZW1wdHlCb2R5OiAgICAgJycsXG4gICAgY29tbWVudExlZnQ6ICAgJyAnLFxuICAgIGNvbW1lbnRSaWdodDogICcgJ1xufTtcblxuZnVuY3Rpb24gY2FwaXRhbGl6ZShzdHIpIHtcbiAgICByZXR1cm4gc3RyWzBdLnRvVXBwZXJDYXNlKCkgKyBzdHIuc2xpY2UoMSk7XG59XG5cbmNsYXNzIFN0cmluZ2lmaWVyIHtcblxuICAgIGNvbnN0cnVjdG9yKGJ1aWxkZXIpIHtcbiAgICAgICAgdGhpcy5idWlsZGVyID0gYnVpbGRlcjtcbiAgICB9XG5cbiAgICBzdHJpbmdpZnkobm9kZSwgc2VtaWNvbG9uKSB7XG4gICAgICAgIHRoaXNbbm9kZS50eXBlXShub2RlLCBzZW1pY29sb24pO1xuICAgIH1cblxuICAgIHJvb3Qobm9kZSkge1xuICAgICAgICB0aGlzLmJvZHkobm9kZSk7XG4gICAgICAgIGlmICggbm9kZS5yYXdzLmFmdGVyICkgdGhpcy5idWlsZGVyKG5vZGUucmF3cy5hZnRlcik7XG4gICAgfVxuXG4gICAgY29tbWVudChub2RlKSB7XG4gICAgICAgIGxldCBsZWZ0ICA9IHRoaXMucmF3KG5vZGUsICdsZWZ0JywgICdjb21tZW50TGVmdCcpO1xuICAgICAgICBsZXQgcmlnaHQgPSB0aGlzLnJhdyhub2RlLCAncmlnaHQnLCAnY29tbWVudFJpZ2h0Jyk7XG4gICAgICAgIHRoaXMuYnVpbGRlcignLyonICsgbGVmdCArIG5vZGUudGV4dCArIHJpZ2h0ICsgJyovJywgbm9kZSk7XG4gICAgfVxuXG4gICAgZGVjbChub2RlLCBzZW1pY29sb24pIHtcbiAgICAgICAgbGV0IGJldHdlZW4gPSB0aGlzLnJhdyhub2RlLCAnYmV0d2VlbicsICdjb2xvbicpO1xuICAgICAgICBsZXQgc3RyaW5nICA9IG5vZGUucHJvcCArIGJldHdlZW4gKyB0aGlzLnJhd1ZhbHVlKG5vZGUsICd2YWx1ZScpO1xuXG4gICAgICAgIGlmICggbm9kZS5pbXBvcnRhbnQgKSB7XG4gICAgICAgICAgICBzdHJpbmcgKz0gbm9kZS5yYXdzLmltcG9ydGFudCB8fCAnICFpbXBvcnRhbnQnO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKCBzZW1pY29sb24gKSBzdHJpbmcgKz0gJzsnO1xuICAgICAgICB0aGlzLmJ1aWxkZXIoc3RyaW5nLCBub2RlKTtcbiAgICB9XG5cbiAgICBydWxlKG5vZGUpIHtcbiAgICAgICAgdGhpcy5ibG9jayhub2RlLCB0aGlzLnJhd1ZhbHVlKG5vZGUsICdzZWxlY3RvcicpKTtcbiAgICB9XG5cbiAgICBhdHJ1bGUobm9kZSwgc2VtaWNvbG9uKSB7XG4gICAgICAgIGxldCBuYW1lICAgPSAnQCcgKyBub2RlLm5hbWU7XG4gICAgICAgIGxldCBwYXJhbXMgPSBub2RlLnBhcmFtcyA/IHRoaXMucmF3VmFsdWUobm9kZSwgJ3BhcmFtcycpIDogJyc7XG5cbiAgICAgICAgaWYgKCB0eXBlb2Ygbm9kZS5yYXdzLmFmdGVyTmFtZSAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICBuYW1lICs9IG5vZGUucmF3cy5hZnRlck5hbWU7XG4gICAgICAgIH0gZWxzZSBpZiAoIHBhcmFtcyApIHtcbiAgICAgICAgICAgIG5hbWUgKz0gJyAnO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKCBub2RlLm5vZGVzICkge1xuICAgICAgICAgICAgdGhpcy5ibG9jayhub2RlLCBuYW1lICsgcGFyYW1zKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIGxldCBlbmQgPSAobm9kZS5yYXdzLmJldHdlZW4gfHwgJycpICsgKHNlbWljb2xvbiA/ICc7JyA6ICcnKTtcbiAgICAgICAgICAgIHRoaXMuYnVpbGRlcihuYW1lICsgcGFyYW1zICsgZW5kLCBub2RlKTtcbiAgICAgICAgfVxuICAgIH1cblxuICAgIGJvZHkobm9kZSkge1xuICAgICAgICBsZXQgbGFzdCA9IG5vZGUubm9kZXMubGVuZ3RoIC0gMTtcbiAgICAgICAgd2hpbGUgKCBsYXN0ID4gMCApIHtcbiAgICAgICAgICAgIGlmICggbm9kZS5ub2Rlc1tsYXN0XS50eXBlICE9PSAnY29tbWVudCcgKSBicmVhaztcbiAgICAgICAgICAgIGxhc3QgLT0gMTtcbiAgICAgICAgfVxuXG4gICAgICAgIGxldCBzZW1pY29sb24gPSB0aGlzLnJhdyhub2RlLCAnc2VtaWNvbG9uJyk7XG4gICAgICAgIGZvciAoIGxldCBpID0gMDsgaSA8IG5vZGUubm9kZXMubGVuZ3RoOyBpKysgKSB7XG4gICAgICAgICAgICBsZXQgY2hpbGQgID0gbm9kZS5ub2Rlc1tpXTtcbiAgICAgICAgICAgIGxldCBiZWZvcmUgPSB0aGlzLnJhdyhjaGlsZCwgJ2JlZm9yZScpO1xuICAgICAgICAgICAgaWYgKCBiZWZvcmUgKSB0aGlzLmJ1aWxkZXIoYmVmb3JlKTtcbiAgICAgICAgICAgIHRoaXMuc3RyaW5naWZ5KGNoaWxkLCBsYXN0ICE9PSBpIHx8IHNlbWljb2xvbik7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBibG9jayhub2RlLCBzdGFydCkge1xuICAgICAgICBsZXQgYmV0d2VlbiA9IHRoaXMucmF3KG5vZGUsICdiZXR3ZWVuJywgJ2JlZm9yZU9wZW4nKTtcbiAgICAgICAgdGhpcy5idWlsZGVyKHN0YXJ0ICsgYmV0d2VlbiArICd7Jywgbm9kZSwgJ3N0YXJ0Jyk7XG5cbiAgICAgICAgbGV0IGFmdGVyO1xuICAgICAgICBpZiAoIG5vZGUubm9kZXMgJiYgbm9kZS5ub2Rlcy5sZW5ndGggKSB7XG4gICAgICAgICAgICB0aGlzLmJvZHkobm9kZSk7XG4gICAgICAgICAgICBhZnRlciA9IHRoaXMucmF3KG5vZGUsICdhZnRlcicpO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgYWZ0ZXIgPSB0aGlzLnJhdyhub2RlLCAnYWZ0ZXInLCAnZW1wdHlCb2R5Jyk7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoIGFmdGVyICkgdGhpcy5idWlsZGVyKGFmdGVyKTtcbiAgICAgICAgdGhpcy5idWlsZGVyKCd9Jywgbm9kZSwgJ2VuZCcpO1xuICAgIH1cblxuICAgIHJhdyhub2RlLCBvd24sIGRldGVjdCkge1xuICAgICAgICBsZXQgdmFsdWU7XG4gICAgICAgIGlmICggIWRldGVjdCApIGRldGVjdCA9IG93bjtcblxuICAgICAgICAvLyBBbHJlYWR5IGhhZFxuICAgICAgICBpZiAoIG93biApIHtcbiAgICAgICAgICAgIHZhbHVlID0gbm9kZS5yYXdzW293bl07XG4gICAgICAgICAgICBpZiAoIHR5cGVvZiB2YWx1ZSAhPT0gJ3VuZGVmaW5lZCcgKSByZXR1cm4gdmFsdWU7XG4gICAgICAgIH1cblxuICAgICAgICBsZXQgcGFyZW50ID0gbm9kZS5wYXJlbnQ7XG5cbiAgICAgICAgLy8gSGFjayBmb3IgZmlyc3QgcnVsZSBpbiBDU1NcbiAgICAgICAgaWYgKCBkZXRlY3QgPT09ICdiZWZvcmUnICkge1xuICAgICAgICAgICAgaWYgKCAhcGFyZW50IHx8IHBhcmVudC50eXBlID09PSAncm9vdCcgJiYgcGFyZW50LmZpcnN0ID09PSBub2RlICkge1xuICAgICAgICAgICAgICAgIHJldHVybiAnJztcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuXG4gICAgICAgIC8vIEZsb2F0aW5nIGNoaWxkIHdpdGhvdXQgcGFyZW50XG4gICAgICAgIGlmICggIXBhcmVudCApIHJldHVybiBkZWZhdWx0UmF3W2RldGVjdF07XG5cbiAgICAgICAgLy8gRGV0ZWN0IHN0eWxlIGJ5IG90aGVyIG5vZGVzXG4gICAgICAgIGxldCByb290ID0gbm9kZS5yb290KCk7XG4gICAgICAgIGlmICggIXJvb3QucmF3Q2FjaGUgKSByb290LnJhd0NhY2hlID0geyB9O1xuICAgICAgICBpZiAoIHR5cGVvZiByb290LnJhd0NhY2hlW2RldGVjdF0gIT09ICd1bmRlZmluZWQnICkge1xuICAgICAgICAgICAgcmV0dXJuIHJvb3QucmF3Q2FjaGVbZGV0ZWN0XTtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmICggZGV0ZWN0ID09PSAnYmVmb3JlJyB8fCBkZXRlY3QgPT09ICdhZnRlcicgKSB7XG4gICAgICAgICAgICByZXR1cm4gdGhpcy5iZWZvcmVBZnRlcihub2RlLCBkZXRlY3QpO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgbGV0IG1ldGhvZCA9ICdyYXcnICsgY2FwaXRhbGl6ZShkZXRlY3QpO1xuICAgICAgICAgICAgaWYgKCB0aGlzW21ldGhvZF0gKSB7XG4gICAgICAgICAgICAgICAgdmFsdWUgPSB0aGlzW21ldGhvZF0ocm9vdCwgbm9kZSk7XG4gICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHJvb3Qud2FsayggaSA9PiB7XG4gICAgICAgICAgICAgICAgICAgIHZhbHVlID0gaS5yYXdzW293bl07XG4gICAgICAgICAgICAgICAgICAgIGlmICggdHlwZW9mIHZhbHVlICE9PSAndW5kZWZpbmVkJyApIHJldHVybiBmYWxzZTtcbiAgICAgICAgICAgICAgICB9KTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuXG4gICAgICAgIGlmICggdHlwZW9mIHZhbHVlID09PSAndW5kZWZpbmVkJyApIHZhbHVlID0gZGVmYXVsdFJhd1tkZXRlY3RdO1xuXG4gICAgICAgIHJvb3QucmF3Q2FjaGVbZGV0ZWN0XSA9IHZhbHVlO1xuICAgICAgICByZXR1cm4gdmFsdWU7XG4gICAgfVxuXG4gICAgcmF3U2VtaWNvbG9uKHJvb3QpIHtcbiAgICAgICAgbGV0IHZhbHVlO1xuICAgICAgICByb290LndhbGsoIGkgPT4ge1xuICAgICAgICAgICAgaWYgKCBpLm5vZGVzICYmIGkubm9kZXMubGVuZ3RoICYmIGkubGFzdC50eXBlID09PSAnZGVjbCcgKSB7XG4gICAgICAgICAgICAgICAgdmFsdWUgPSBpLnJhd3Muc2VtaWNvbG9uO1xuICAgICAgICAgICAgICAgIGlmICggdHlwZW9mIHZhbHVlICE9PSAndW5kZWZpbmVkJyApIHJldHVybiBmYWxzZTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfSk7XG4gICAgICAgIHJldHVybiB2YWx1ZTtcbiAgICB9XG5cbiAgICByYXdFbXB0eUJvZHkocm9vdCkge1xuICAgICAgICBsZXQgdmFsdWU7XG4gICAgICAgIHJvb3Qud2FsayggaSA9PiB7XG4gICAgICAgICAgICBpZiAoIGkubm9kZXMgJiYgaS5ub2Rlcy5sZW5ndGggPT09IDAgKSB7XG4gICAgICAgICAgICAgICAgdmFsdWUgPSBpLnJhd3MuYWZ0ZXI7XG4gICAgICAgICAgICAgICAgaWYgKCB0eXBlb2YgdmFsdWUgIT09ICd1bmRlZmluZWQnICkgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgfVxuICAgICAgICB9KTtcbiAgICAgICAgcmV0dXJuIHZhbHVlO1xuICAgIH1cblxuICAgIHJhd0luZGVudChyb290KSB7XG4gICAgICAgIGlmICggcm9vdC5yYXdzLmluZGVudCApIHJldHVybiByb290LnJhd3MuaW5kZW50O1xuICAgICAgICBsZXQgdmFsdWU7XG4gICAgICAgIHJvb3Qud2FsayggaSA9PiB7XG4gICAgICAgICAgICBsZXQgcCA9IGkucGFyZW50O1xuICAgICAgICAgICAgaWYgKCBwICYmIHAgIT09IHJvb3QgJiYgcC5wYXJlbnQgJiYgcC5wYXJlbnQgPT09IHJvb3QgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCB0eXBlb2YgaS5yYXdzLmJlZm9yZSAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICAgICAgICAgIGxldCBwYXJ0cyA9IGkucmF3cy5iZWZvcmUuc3BsaXQoJ1xcbicpO1xuICAgICAgICAgICAgICAgICAgICB2YWx1ZSA9IHBhcnRzW3BhcnRzLmxlbmd0aCAtIDFdO1xuICAgICAgICAgICAgICAgICAgICB2YWx1ZSA9IHZhbHVlLnJlcGxhY2UoL1teXFxzXS9nLCAnJyk7XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG4gICAgICAgIH0pO1xuICAgICAgICByZXR1cm4gdmFsdWU7XG4gICAgfVxuXG4gICAgcmF3QmVmb3JlQ29tbWVudChyb290LCBub2RlKSB7XG4gICAgICAgIGxldCB2YWx1ZTtcbiAgICAgICAgcm9vdC53YWxrQ29tbWVudHMoIGkgPT4ge1xuICAgICAgICAgICAgaWYgKCB0eXBlb2YgaS5yYXdzLmJlZm9yZSAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICAgICAgdmFsdWUgPSBpLnJhd3MuYmVmb3JlO1xuICAgICAgICAgICAgICAgIGlmICggdmFsdWUuaW5kZXhPZignXFxuJykgIT09IC0xICkge1xuICAgICAgICAgICAgICAgICAgICB2YWx1ZSA9IHZhbHVlLnJlcGxhY2UoL1teXFxuXSskLywgJycpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICB9XG4gICAgICAgIH0pO1xuICAgICAgICBpZiAoIHR5cGVvZiB2YWx1ZSA9PT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICB2YWx1ZSA9IHRoaXMucmF3KG5vZGUsIG51bGwsICdiZWZvcmVEZWNsJyk7XG4gICAgICAgIH1cbiAgICAgICAgcmV0dXJuIHZhbHVlO1xuICAgIH1cblxuICAgIHJhd0JlZm9yZURlY2wocm9vdCwgbm9kZSkge1xuICAgICAgICBsZXQgdmFsdWU7XG4gICAgICAgIHJvb3Qud2Fsa0RlY2xzKCBpID0+IHtcbiAgICAgICAgICAgIGlmICggdHlwZW9mIGkucmF3cy5iZWZvcmUgIT09ICd1bmRlZmluZWQnICkge1xuICAgICAgICAgICAgICAgIHZhbHVlID0gaS5yYXdzLmJlZm9yZTtcbiAgICAgICAgICAgICAgICBpZiAoIHZhbHVlLmluZGV4T2YoJ1xcbicpICE9PSAtMSApIHtcbiAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSB2YWx1ZS5yZXBsYWNlKC9bXlxcbl0rJC8sICcnKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgfVxuICAgICAgICB9KTtcbiAgICAgICAgaWYgKCB0eXBlb2YgdmFsdWUgPT09ICd1bmRlZmluZWQnICkge1xuICAgICAgICAgICAgdmFsdWUgPSB0aGlzLnJhdyhub2RlLCBudWxsLCAnYmVmb3JlUnVsZScpO1xuICAgICAgICB9XG4gICAgICAgIHJldHVybiB2YWx1ZTtcbiAgICB9XG5cbiAgICByYXdCZWZvcmVSdWxlKHJvb3QpIHtcbiAgICAgICAgbGV0IHZhbHVlO1xuICAgICAgICByb290LndhbGsoIGkgPT4ge1xuICAgICAgICAgICAgaWYgKCBpLm5vZGVzICYmIChpLnBhcmVudCAhPT0gcm9vdCB8fCByb290LmZpcnN0ICE9PSBpKSApIHtcbiAgICAgICAgICAgICAgICBpZiAoIHR5cGVvZiBpLnJhd3MuYmVmb3JlICE9PSAndW5kZWZpbmVkJyApIHtcbiAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSBpLnJhd3MuYmVmb3JlO1xuICAgICAgICAgICAgICAgICAgICBpZiAoIHZhbHVlLmluZGV4T2YoJ1xcbicpICE9PSAtMSApIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlID0gdmFsdWUucmVwbGFjZSgvW15cXG5dKyQvLCAnJyk7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH1cbiAgICAgICAgfSk7XG4gICAgICAgIHJldHVybiB2YWx1ZTtcbiAgICB9XG5cbiAgICByYXdCZWZvcmVDbG9zZShyb290KSB7XG4gICAgICAgIGxldCB2YWx1ZTtcbiAgICAgICAgcm9vdC53YWxrKCBpID0+IHtcbiAgICAgICAgICAgIGlmICggaS5ub2RlcyAmJiBpLm5vZGVzLmxlbmd0aCA+IDAgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCB0eXBlb2YgaS5yYXdzLmFmdGVyICE9PSAndW5kZWZpbmVkJyApIHtcbiAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSBpLnJhd3MuYWZ0ZXI7XG4gICAgICAgICAgICAgICAgICAgIGlmICggdmFsdWUuaW5kZXhPZignXFxuJykgIT09IC0xICkge1xuICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSB2YWx1ZS5yZXBsYWNlKC9bXlxcbl0rJC8sICcnKTtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9KTtcbiAgICAgICAgcmV0dXJuIHZhbHVlO1xuICAgIH1cblxuICAgIHJhd0JlZm9yZU9wZW4ocm9vdCkge1xuICAgICAgICBsZXQgdmFsdWU7XG4gICAgICAgIHJvb3Qud2FsayggaSA9PiB7XG4gICAgICAgICAgICBpZiAoIGkudHlwZSAhPT0gJ2RlY2wnICkge1xuICAgICAgICAgICAgICAgIHZhbHVlID0gaS5yYXdzLmJldHdlZW47XG4gICAgICAgICAgICAgICAgaWYgKCB0eXBlb2YgdmFsdWUgIT09ICd1bmRlZmluZWQnICkgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgfVxuICAgICAgICB9KTtcbiAgICAgICAgcmV0dXJuIHZhbHVlO1xuICAgIH1cblxuICAgIHJhd0NvbG9uKHJvb3QpIHtcbiAgICAgICAgbGV0IHZhbHVlO1xuICAgICAgICByb290LndhbGtEZWNscyggaSA9PiB7XG4gICAgICAgICAgICBpZiAoIHR5cGVvZiBpLnJhd3MuYmV0d2VlbiAhPT0gJ3VuZGVmaW5lZCcgKSB7XG4gICAgICAgICAgICAgICAgdmFsdWUgPSBpLnJhd3MuYmV0d2Vlbi5yZXBsYWNlKC9bXlxcczpdL2csICcnKTtcbiAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICB9XG4gICAgICAgIH0pO1xuICAgICAgICByZXR1cm4gdmFsdWU7XG4gICAgfVxuXG4gICAgYmVmb3JlQWZ0ZXIobm9kZSwgZGV0ZWN0KSB7XG4gICAgICAgIGxldCB2YWx1ZTtcbiAgICAgICAgaWYgKCBub2RlLnR5cGUgPT09ICdkZWNsJyApIHtcbiAgICAgICAgICAgIHZhbHVlID0gdGhpcy5yYXcobm9kZSwgbnVsbCwgJ2JlZm9yZURlY2wnKTtcbiAgICAgICAgfSBlbHNlIGlmICggbm9kZS50eXBlID09PSAnY29tbWVudCcgKSB7XG4gICAgICAgICAgICB2YWx1ZSA9IHRoaXMucmF3KG5vZGUsIG51bGwsICdiZWZvcmVDb21tZW50Jyk7XG4gICAgICAgIH0gZWxzZSBpZiAoIGRldGVjdCA9PT0gJ2JlZm9yZScgKSB7XG4gICAgICAgICAgICB2YWx1ZSA9IHRoaXMucmF3KG5vZGUsIG51bGwsICdiZWZvcmVSdWxlJyk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICB2YWx1ZSA9IHRoaXMucmF3KG5vZGUsIG51bGwsICdiZWZvcmVDbG9zZScpO1xuICAgICAgICB9XG5cbiAgICAgICAgbGV0IGJ1ZiAgID0gbm9kZS5wYXJlbnQ7XG4gICAgICAgIGxldCBkZXB0aCA9IDA7XG4gICAgICAgIHdoaWxlICggYnVmICYmIGJ1Zi50eXBlICE9PSAncm9vdCcgKSB7XG4gICAgICAgICAgICBkZXB0aCArPSAxO1xuICAgICAgICAgICAgYnVmID0gYnVmLnBhcmVudDtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmICggdmFsdWUuaW5kZXhPZignXFxuJykgIT09IC0xICkge1xuICAgICAgICAgICAgbGV0IGluZGVudCA9IHRoaXMucmF3KG5vZGUsIG51bGwsICdpbmRlbnQnKTtcbiAgICAgICAgICAgIGlmICggaW5kZW50Lmxlbmd0aCApIHtcbiAgICAgICAgICAgICAgICBmb3IgKCBsZXQgc3RlcCA9IDA7IHN0ZXAgPCBkZXB0aDsgc3RlcCsrICkgdmFsdWUgKz0gaW5kZW50O1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIHZhbHVlO1xuICAgIH1cblxuICAgIHJhd1ZhbHVlKG5vZGUsIHByb3ApIHtcbiAgICAgICAgbGV0IHZhbHVlID0gbm9kZVtwcm9wXTtcbiAgICAgICAgbGV0IHJhdyAgID0gbm9kZS5yYXdzW3Byb3BdO1xuICAgICAgICBpZiAoIHJhdyAmJiByYXcudmFsdWUgPT09IHZhbHVlICkge1xuICAgICAgICAgICAgcmV0dXJuIHJhdy5yYXc7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICByZXR1cm4gdmFsdWU7XG4gICAgICAgIH1cbiAgICB9XG5cbn1cblxuZXhwb3J0IGRlZmF1bHQgU3RyaW5naWZpZXI7XG4iXX0=
