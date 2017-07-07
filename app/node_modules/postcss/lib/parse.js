'use strict';

exports.__esModule = true;
exports.default = parse;

var _parser = require('./parser');

var _parser2 = _interopRequireDefault(_parser);

var _input = require('./input');

var _input2 = _interopRequireDefault(_input);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function parse(css, opts) {
    if (opts && opts.safe) {
        throw new Error('Option safe was removed. ' + 'Use parser: require("postcss-safe-parser")');
    }

    var input = new _input2.default(css, opts);

    var parser = new _parser2.default(input);
    try {
        parser.tokenize();
        parser.loop();
    } catch (e) {
        if (e.name === 'CssSyntaxError' && opts && opts.from) {
            if (/\.scss$/i.test(opts.from)) {
                e.message += '\nYou tried to parse SCSS with ' + 'the standard CSS parser; ' + 'try again with the postcss-scss parser';
            } else if (/\.less$/i.test(opts.from)) {
                e.message += '\nYou tried to parse Less with ' + 'the standard CSS parser; ' + 'try again with the postcss-less parser';
            }
        }
        throw e;
    }

    return parser.root;
}
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvcGFyc2UuZXM2Il0sIm5hbWVzIjpbInBhcnNlIiwiY3NzIiwib3B0cyIsInNhZmUiLCJFcnJvciIsImlucHV0IiwicGFyc2VyIiwidG9rZW5pemUiLCJsb29wIiwiZSIsIm5hbWUiLCJmcm9tIiwidGVzdCIsIm1lc3NhZ2UiLCJyb290Il0sIm1hcHBpbmdzIjoiOzs7a0JBR3dCQSxLOztBQUh4Qjs7OztBQUNBOzs7Ozs7QUFFZSxTQUFTQSxLQUFULENBQWVDLEdBQWYsRUFBb0JDLElBQXBCLEVBQTBCO0FBQ3JDLFFBQUtBLFFBQVFBLEtBQUtDLElBQWxCLEVBQXlCO0FBQ3JCLGNBQU0sSUFBSUMsS0FBSixDQUFVLDhCQUNBLDRDQURWLENBQU47QUFFSDs7QUFFRCxRQUFJQyxRQUFRLG9CQUFVSixHQUFWLEVBQWVDLElBQWYsQ0FBWjs7QUFFQSxRQUFJSSxTQUFTLHFCQUFXRCxLQUFYLENBQWI7QUFDQSxRQUFJO0FBQ0FDLGVBQU9DLFFBQVA7QUFDQUQsZUFBT0UsSUFBUDtBQUNILEtBSEQsQ0FHRSxPQUFPQyxDQUFQLEVBQVU7QUFDUixZQUFLQSxFQUFFQyxJQUFGLEtBQVcsZ0JBQVgsSUFBK0JSLElBQS9CLElBQXVDQSxLQUFLUyxJQUFqRCxFQUF3RDtBQUNwRCxnQkFBSyxXQUFXQyxJQUFYLENBQWdCVixLQUFLUyxJQUFyQixDQUFMLEVBQWtDO0FBQzlCRixrQkFBRUksT0FBRixJQUFhLG9DQUNBLDJCQURBLEdBRUEsd0NBRmI7QUFHSCxhQUpELE1BSU8sSUFBSyxXQUFXRCxJQUFYLENBQWdCVixLQUFLUyxJQUFyQixDQUFMLEVBQWtDO0FBQ3JDRixrQkFBRUksT0FBRixJQUFhLG9DQUNBLDJCQURBLEdBRUEsd0NBRmI7QUFHSDtBQUNKO0FBQ0QsY0FBTUosQ0FBTjtBQUNIOztBQUVELFdBQU9ILE9BQU9RLElBQWQ7QUFDSCIsImZpbGUiOiJwYXJzZS5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBQYXJzZXIgZnJvbSAnLi9wYXJzZXInO1xuaW1wb3J0IElucHV0ICBmcm9tICcuL2lucHV0JztcblxuZXhwb3J0IGRlZmF1bHQgZnVuY3Rpb24gcGFyc2UoY3NzLCBvcHRzKSB7XG4gICAgaWYgKCBvcHRzICYmIG9wdHMuc2FmZSApIHtcbiAgICAgICAgdGhyb3cgbmV3IEVycm9yKCdPcHRpb24gc2FmZSB3YXMgcmVtb3ZlZC4gJyArXG4gICAgICAgICAgICAgICAgICAgICAgICAnVXNlIHBhcnNlcjogcmVxdWlyZShcInBvc3Rjc3Mtc2FmZS1wYXJzZXJcIiknKTtcbiAgICB9XG5cbiAgICBsZXQgaW5wdXQgPSBuZXcgSW5wdXQoY3NzLCBvcHRzKTtcblxuICAgIGxldCBwYXJzZXIgPSBuZXcgUGFyc2VyKGlucHV0KTtcbiAgICB0cnkge1xuICAgICAgICBwYXJzZXIudG9rZW5pemUoKTtcbiAgICAgICAgcGFyc2VyLmxvb3AoKTtcbiAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgIGlmICggZS5uYW1lID09PSAnQ3NzU3ludGF4RXJyb3InICYmIG9wdHMgJiYgb3B0cy5mcm9tICkge1xuICAgICAgICAgICAgaWYgKCAvXFwuc2NzcyQvaS50ZXN0KG9wdHMuZnJvbSkgKSB7XG4gICAgICAgICAgICAgICAgZS5tZXNzYWdlICs9ICdcXG5Zb3UgdHJpZWQgdG8gcGFyc2UgU0NTUyB3aXRoICcgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAndGhlIHN0YW5kYXJkIENTUyBwYXJzZXI7ICcgK1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAndHJ5IGFnYWluIHdpdGggdGhlIHBvc3Rjc3Mtc2NzcyBwYXJzZXInO1xuICAgICAgICAgICAgfSBlbHNlIGlmICggL1xcLmxlc3MkL2kudGVzdChvcHRzLmZyb20pICkge1xuICAgICAgICAgICAgICAgIGUubWVzc2FnZSArPSAnXFxuWW91IHRyaWVkIHRvIHBhcnNlIExlc3Mgd2l0aCAnICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3RoZSBzdGFuZGFyZCBDU1MgcGFyc2VyOyAnICtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3RyeSBhZ2FpbiB3aXRoIHRoZSBwb3N0Y3NzLWxlc3MgcGFyc2VyJztcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICB0aHJvdyBlO1xuICAgIH1cblxuICAgIHJldHVybiBwYXJzZXIucm9vdDtcbn1cbiJdfQ==
