'use strict';

exports.__esModule = true;

var _chalk = require('chalk');

var _chalk2 = _interopRequireDefault(_chalk);

var _tokenize = require('./tokenize');

var _tokenize2 = _interopRequireDefault(_tokenize);

var _input = require('./input');

var _input2 = _interopRequireDefault(_input);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var colors = new _chalk2.default.constructor({ enabled: true });

var HIGHLIGHT_THEME = {
    'brackets': colors.cyan,
    'at-word': colors.cyan,
    'call': colors.cyan,
    'comment': colors.gray,
    'string': colors.green,
    'class': colors.yellow,
    'hash': colors.magenta,
    '(': colors.cyan,
    ')': colors.cyan,
    '{': colors.yellow,
    '}': colors.yellow,
    '[': colors.yellow,
    ']': colors.yellow,
    ':': colors.yellow,
    ';': colors.yellow
};

function getTokenType(_ref, index, tokens) {
    var type = _ref[0],
        value = _ref[1];

    if (type === 'word') {
        if (value[0] === '.') {
            return 'class';
        }
        if (value[0] === '#') {
            return 'hash';
        }
    }

    var nextToken = tokens[index + 1];
    if (nextToken && (nextToken[0] === 'brackets' || nextToken[0] === '(')) {
        return 'call';
    }

    return type;
}

function terminalHighlight(css) {
    var tokens = (0, _tokenize2.default)(new _input2.default(css), { ignoreErrors: true });
    return tokens.map(function (token, index) {
        var color = HIGHLIGHT_THEME[getTokenType(token, index, tokens)];
        if (color) {
            return token[1].split(/\r?\n/).map(function (i) {
                return color(i);
            }).join('\n');
        } else {
            return token[1];
        }
    }).join('');
}

exports.default = terminalHighlight;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvdGVybWluYWwtaGlnaGxpZ2h0LmVzNiJdLCJuYW1lcyI6WyJjb2xvcnMiLCJjb25zdHJ1Y3RvciIsImVuYWJsZWQiLCJISUdITElHSFRfVEhFTUUiLCJjeWFuIiwiZ3JheSIsImdyZWVuIiwieWVsbG93IiwibWFnZW50YSIsImdldFRva2VuVHlwZSIsImluZGV4IiwidG9rZW5zIiwidHlwZSIsInZhbHVlIiwibmV4dFRva2VuIiwidGVybWluYWxIaWdobGlnaHQiLCJjc3MiLCJpZ25vcmVFcnJvcnMiLCJtYXAiLCJ0b2tlbiIsImNvbG9yIiwic3BsaXQiLCJpIiwiam9pbiJdLCJtYXBwaW5ncyI6Ijs7OztBQUFBOzs7O0FBRUE7Ozs7QUFDQTs7Ozs7O0FBRUEsSUFBSUEsU0FBUyxJQUFJLGdCQUFNQyxXQUFWLENBQXNCLEVBQUVDLFNBQVMsSUFBWCxFQUF0QixDQUFiOztBQUVBLElBQU1DLGtCQUFrQjtBQUNwQixnQkFBWUgsT0FBT0ksSUFEQztBQUVwQixlQUFZSixPQUFPSSxJQUZDO0FBR3BCLFlBQVlKLE9BQU9JLElBSEM7QUFJcEIsZUFBWUosT0FBT0ssSUFKQztBQUtwQixjQUFZTCxPQUFPTSxLQUxDO0FBTXBCLGFBQVlOLE9BQU9PLE1BTkM7QUFPcEIsWUFBWVAsT0FBT1EsT0FQQztBQVFwQixTQUFZUixPQUFPSSxJQVJDO0FBU3BCLFNBQVlKLE9BQU9JLElBVEM7QUFVcEIsU0FBWUosT0FBT08sTUFWQztBQVdwQixTQUFZUCxPQUFPTyxNQVhDO0FBWXBCLFNBQVlQLE9BQU9PLE1BWkM7QUFhcEIsU0FBWVAsT0FBT08sTUFiQztBQWNwQixTQUFZUCxPQUFPTyxNQWRDO0FBZXBCLFNBQVlQLE9BQU9PO0FBZkMsQ0FBeEI7O0FBa0JBLFNBQVNFLFlBQVQsT0FBcUNDLEtBQXJDLEVBQTRDQyxNQUE1QyxFQUFvRDtBQUFBLFFBQTdCQyxJQUE2QjtBQUFBLFFBQXZCQyxLQUF1Qjs7QUFDaEQsUUFBSUQsU0FBUyxNQUFiLEVBQXFCO0FBQ2pCLFlBQUlDLE1BQU0sQ0FBTixNQUFhLEdBQWpCLEVBQXNCO0FBQ2xCLG1CQUFPLE9BQVA7QUFDSDtBQUNELFlBQUlBLE1BQU0sQ0FBTixNQUFhLEdBQWpCLEVBQXNCO0FBQ2xCLG1CQUFPLE1BQVA7QUFDSDtBQUNKOztBQUVELFFBQUlDLFlBQVlILE9BQU9ELFFBQVEsQ0FBZixDQUFoQjtBQUNBLFFBQUlJLGNBQWNBLFVBQVUsQ0FBVixNQUFpQixVQUFqQixJQUErQkEsVUFBVSxDQUFWLE1BQWlCLEdBQTlELENBQUosRUFBd0U7QUFDcEUsZUFBTyxNQUFQO0FBQ0g7O0FBRUQsV0FBT0YsSUFBUDtBQUNIOztBQUVELFNBQVNHLGlCQUFULENBQTJCQyxHQUEzQixFQUFnQztBQUM1QixRQUFJTCxTQUFTLHdCQUFTLG9CQUFVSyxHQUFWLENBQVQsRUFBeUIsRUFBRUMsY0FBYyxJQUFoQixFQUF6QixDQUFiO0FBQ0EsV0FBT04sT0FBT08sR0FBUCxDQUFXLFVBQUNDLEtBQUQsRUFBUVQsS0FBUixFQUFrQjtBQUNoQyxZQUFJVSxRQUFRakIsZ0JBQWdCTSxhQUFhVSxLQUFiLEVBQW9CVCxLQUFwQixFQUEyQkMsTUFBM0IsQ0FBaEIsQ0FBWjtBQUNBLFlBQUtTLEtBQUwsRUFBYTtBQUNULG1CQUFPRCxNQUFNLENBQU4sRUFBU0UsS0FBVCxDQUFlLE9BQWYsRUFDSkgsR0FESSxDQUNDO0FBQUEsdUJBQUtFLE1BQU1FLENBQU4sQ0FBTDtBQUFBLGFBREQsRUFFSkMsSUFGSSxDQUVDLElBRkQsQ0FBUDtBQUdILFNBSkQsTUFJTztBQUNILG1CQUFPSixNQUFNLENBQU4sQ0FBUDtBQUNIO0FBQ0osS0FUTSxFQVNKSSxJQVRJLENBU0MsRUFURCxDQUFQO0FBVUg7O2tCQUVjUixpQiIsImZpbGUiOiJ0ZXJtaW5hbC1oaWdobGlnaHQuanMiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgY2hhbGsgZnJvbSAnY2hhbGsnO1xuXG5pbXBvcnQgdG9rZW5pemUgZnJvbSAnLi90b2tlbml6ZSc7XG5pbXBvcnQgSW5wdXQgICAgZnJvbSAnLi9pbnB1dCc7XG5cbmxldCBjb2xvcnMgPSBuZXcgY2hhbGsuY29uc3RydWN0b3IoeyBlbmFibGVkOiB0cnVlIH0pO1xuXG5jb25zdCBISUdITElHSFRfVEhFTUUgPSB7XG4gICAgJ2JyYWNrZXRzJzogY29sb3JzLmN5YW4sXG4gICAgJ2F0LXdvcmQnOiAgY29sb3JzLmN5YW4sXG4gICAgJ2NhbGwnOiAgICAgY29sb3JzLmN5YW4sXG4gICAgJ2NvbW1lbnQnOiAgY29sb3JzLmdyYXksXG4gICAgJ3N0cmluZyc6ICAgY29sb3JzLmdyZWVuLFxuICAgICdjbGFzcyc6ICAgIGNvbG9ycy55ZWxsb3csXG4gICAgJ2hhc2gnOiAgICAgY29sb3JzLm1hZ2VudGEsXG4gICAgJygnOiAgICAgICAgY29sb3JzLmN5YW4sXG4gICAgJyknOiAgICAgICAgY29sb3JzLmN5YW4sXG4gICAgJ3snOiAgICAgICAgY29sb3JzLnllbGxvdyxcbiAgICAnfSc6ICAgICAgICBjb2xvcnMueWVsbG93LFxuICAgICdbJzogICAgICAgIGNvbG9ycy55ZWxsb3csXG4gICAgJ10nOiAgICAgICAgY29sb3JzLnllbGxvdyxcbiAgICAnOic6ICAgICAgICBjb2xvcnMueWVsbG93LFxuICAgICc7JzogICAgICAgIGNvbG9ycy55ZWxsb3dcbn07XG5cbmZ1bmN0aW9uIGdldFRva2VuVHlwZShbdHlwZSwgdmFsdWVdLCBpbmRleCwgdG9rZW5zKSB7XG4gICAgaWYgKHR5cGUgPT09ICd3b3JkJykge1xuICAgICAgICBpZiAodmFsdWVbMF0gPT09ICcuJykge1xuICAgICAgICAgICAgcmV0dXJuICdjbGFzcyc7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHZhbHVlWzBdID09PSAnIycpIHtcbiAgICAgICAgICAgIHJldHVybiAnaGFzaCc7XG4gICAgICAgIH1cbiAgICB9XG5cbiAgICBsZXQgbmV4dFRva2VuID0gdG9rZW5zW2luZGV4ICsgMV07XG4gICAgaWYgKG5leHRUb2tlbiAmJiAobmV4dFRva2VuWzBdID09PSAnYnJhY2tldHMnIHx8IG5leHRUb2tlblswXSA9PT0gJygnKSkge1xuICAgICAgICByZXR1cm4gJ2NhbGwnO1xuICAgIH1cblxuICAgIHJldHVybiB0eXBlO1xufVxuXG5mdW5jdGlvbiB0ZXJtaW5hbEhpZ2hsaWdodChjc3MpIHtcbiAgICBsZXQgdG9rZW5zID0gdG9rZW5pemUobmV3IElucHV0KGNzcyksIHsgaWdub3JlRXJyb3JzOiB0cnVlIH0pO1xuICAgIHJldHVybiB0b2tlbnMubWFwKCh0b2tlbiwgaW5kZXgpID0+IHtcbiAgICAgICAgbGV0IGNvbG9yID0gSElHSExJR0hUX1RIRU1FW2dldFRva2VuVHlwZSh0b2tlbiwgaW5kZXgsIHRva2VucyldO1xuICAgICAgICBpZiAoIGNvbG9yICkge1xuICAgICAgICAgICAgcmV0dXJuIHRva2VuWzFdLnNwbGl0KC9cXHI/XFxuLylcbiAgICAgICAgICAgICAgLm1hcCggaSA9PiBjb2xvcihpKSApXG4gICAgICAgICAgICAgIC5qb2luKCdcXG4nKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiB0b2tlblsxXTtcbiAgICAgICAgfVxuICAgIH0pLmpvaW4oJycpO1xufVxuXG5leHBvcnQgZGVmYXVsdCB0ZXJtaW5hbEhpZ2hsaWdodDtcbiJdfQ==
