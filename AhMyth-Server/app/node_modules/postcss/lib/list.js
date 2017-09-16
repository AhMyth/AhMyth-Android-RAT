'use strict';

exports.__esModule = true;
/**
 * Contains helpers for safely splitting lists of CSS values,
 * preserving parentheses and quotes.
 *
 * @example
 * const list = postcss.list;
 *
 * @namespace list
 */
var list = {
    split: function split(string, separators, last) {
        var array = [];
        var current = '';
        var split = false;

        var func = 0;
        var quote = false;
        var escape = false;

        for (var i = 0; i < string.length; i++) {
            var letter = string[i];

            if (quote) {
                if (escape) {
                    escape = false;
                } else if (letter === '\\') {
                    escape = true;
                } else if (letter === quote) {
                    quote = false;
                }
            } else if (letter === '"' || letter === '\'') {
                quote = letter;
            } else if (letter === '(') {
                func += 1;
            } else if (letter === ')') {
                if (func > 0) func -= 1;
            } else if (func === 0) {
                if (separators.indexOf(letter) !== -1) split = true;
            }

            if (split) {
                if (current !== '') array.push(current.trim());
                current = '';
                split = false;
            } else {
                current += letter;
            }
        }

        if (last || current !== '') array.push(current.trim());
        return array;
    },


    /**
     * Safely splits space-separated values (such as those for `background`,
     * `border-radius`, and other shorthand properties).
     *
     * @param {string} string - space-separated values
     *
     * @return {string[]} split values
     *
     * @example
     * postcss.list.space('1px calc(10% + 1px)') //=> ['1px', 'calc(10% + 1px)']
     */
    space: function space(string) {
        var spaces = [' ', '\n', '\t'];
        return list.split(string, spaces);
    },


    /**
     * Safely splits comma-separated values (such as those for `transition-*`
     * and `background` properties).
     *
     * @param {string} string - comma-separated values
     *
     * @return {string[]} split values
     *
     * @example
     * postcss.list.comma('black, linear-gradient(white, black)')
     * //=> ['black', 'linear-gradient(white, black)']
     */
    comma: function comma(string) {
        var comma = ',';
        return list.split(string, [comma], true);
    }
};

exports.default = list;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvbGlzdC5lczYiXSwibmFtZXMiOlsibGlzdCIsInNwbGl0Iiwic3RyaW5nIiwic2VwYXJhdG9ycyIsImxhc3QiLCJhcnJheSIsImN1cnJlbnQiLCJmdW5jIiwicXVvdGUiLCJlc2NhcGUiLCJpIiwibGVuZ3RoIiwibGV0dGVyIiwiaW5kZXhPZiIsInB1c2giLCJ0cmltIiwic3BhY2UiLCJzcGFjZXMiLCJjb21tYSJdLCJtYXBwaW5ncyI6Ijs7O0FBQUE7Ozs7Ozs7OztBQVNBLElBQUlBLE9BQU87QUFFUEMsU0FGTyxpQkFFREMsTUFGQyxFQUVPQyxVQUZQLEVBRW1CQyxJQUZuQixFQUV5QjtBQUM1QixZQUFJQyxRQUFVLEVBQWQ7QUFDQSxZQUFJQyxVQUFVLEVBQWQ7QUFDQSxZQUFJTCxRQUFVLEtBQWQ7O0FBRUEsWUFBSU0sT0FBVSxDQUFkO0FBQ0EsWUFBSUMsUUFBVSxLQUFkO0FBQ0EsWUFBSUMsU0FBVSxLQUFkOztBQUVBLGFBQU0sSUFBSUMsSUFBSSxDQUFkLEVBQWlCQSxJQUFJUixPQUFPUyxNQUE1QixFQUFvQ0QsR0FBcEMsRUFBMEM7QUFDdEMsZ0JBQUlFLFNBQVNWLE9BQU9RLENBQVAsQ0FBYjs7QUFFQSxnQkFBS0YsS0FBTCxFQUFhO0FBQ1Qsb0JBQUtDLE1BQUwsRUFBYztBQUNWQSw2QkFBUyxLQUFUO0FBQ0gsaUJBRkQsTUFFTyxJQUFLRyxXQUFXLElBQWhCLEVBQXVCO0FBQzFCSCw2QkFBUyxJQUFUO0FBQ0gsaUJBRk0sTUFFQSxJQUFLRyxXQUFXSixLQUFoQixFQUF3QjtBQUMzQkEsNEJBQVEsS0FBUjtBQUNIO0FBQ0osYUFSRCxNQVFPLElBQUtJLFdBQVcsR0FBWCxJQUFrQkEsV0FBVyxJQUFsQyxFQUF5QztBQUM1Q0osd0JBQVFJLE1BQVI7QUFDSCxhQUZNLE1BRUEsSUFBS0EsV0FBVyxHQUFoQixFQUFzQjtBQUN6Qkwsd0JBQVEsQ0FBUjtBQUNILGFBRk0sTUFFQSxJQUFLSyxXQUFXLEdBQWhCLEVBQXNCO0FBQ3pCLG9CQUFLTCxPQUFPLENBQVosRUFBZ0JBLFFBQVEsQ0FBUjtBQUNuQixhQUZNLE1BRUEsSUFBS0EsU0FBUyxDQUFkLEVBQWtCO0FBQ3JCLG9CQUFLSixXQUFXVSxPQUFYLENBQW1CRCxNQUFuQixNQUErQixDQUFDLENBQXJDLEVBQXlDWCxRQUFRLElBQVI7QUFDNUM7O0FBRUQsZ0JBQUtBLEtBQUwsRUFBYTtBQUNULG9CQUFLSyxZQUFZLEVBQWpCLEVBQXNCRCxNQUFNUyxJQUFOLENBQVdSLFFBQVFTLElBQVIsRUFBWDtBQUN0QlQsMEJBQVUsRUFBVjtBQUNBTCx3QkFBVSxLQUFWO0FBQ0gsYUFKRCxNQUlPO0FBQ0hLLDJCQUFXTSxNQUFYO0FBQ0g7QUFDSjs7QUFFRCxZQUFLUixRQUFRRSxZQUFZLEVBQXpCLEVBQThCRCxNQUFNUyxJQUFOLENBQVdSLFFBQVFTLElBQVIsRUFBWDtBQUM5QixlQUFPVixLQUFQO0FBQ0gsS0EzQ007OztBQTZDUDs7Ozs7Ozs7Ozs7QUFXQVcsU0F4RE8saUJBd0REZCxNQXhEQyxFQXdETztBQUNWLFlBQUllLFNBQVMsQ0FBQyxHQUFELEVBQU0sSUFBTixFQUFZLElBQVosQ0FBYjtBQUNBLGVBQU9qQixLQUFLQyxLQUFMLENBQVdDLE1BQVgsRUFBbUJlLE1BQW5CLENBQVA7QUFDSCxLQTNETTs7O0FBNkRQOzs7Ozs7Ozs7Ozs7QUFZQUMsU0F6RU8saUJBeUVEaEIsTUF6RUMsRUF5RU87QUFDVixZQUFJZ0IsUUFBUSxHQUFaO0FBQ0EsZUFBT2xCLEtBQUtDLEtBQUwsQ0FBV0MsTUFBWCxFQUFtQixDQUFDZ0IsS0FBRCxDQUFuQixFQUE0QixJQUE1QixDQUFQO0FBQ0g7QUE1RU0sQ0FBWDs7a0JBZ0ZlbEIsSSIsImZpbGUiOiJsaXN0LmpzIiwic291cmNlc0NvbnRlbnQiOlsiLyoqXG4gKiBDb250YWlucyBoZWxwZXJzIGZvciBzYWZlbHkgc3BsaXR0aW5nIGxpc3RzIG9mIENTUyB2YWx1ZXMsXG4gKiBwcmVzZXJ2aW5nIHBhcmVudGhlc2VzIGFuZCBxdW90ZXMuXG4gKlxuICogQGV4YW1wbGVcbiAqIGNvbnN0IGxpc3QgPSBwb3N0Y3NzLmxpc3Q7XG4gKlxuICogQG5hbWVzcGFjZSBsaXN0XG4gKi9cbmxldCBsaXN0ID0ge1xuXG4gICAgc3BsaXQoc3RyaW5nLCBzZXBhcmF0b3JzLCBsYXN0KSB7XG4gICAgICAgIGxldCBhcnJheSAgID0gW107XG4gICAgICAgIGxldCBjdXJyZW50ID0gJyc7XG4gICAgICAgIGxldCBzcGxpdCAgID0gZmFsc2U7XG5cbiAgICAgICAgbGV0IGZ1bmMgICAgPSAwO1xuICAgICAgICBsZXQgcXVvdGUgICA9IGZhbHNlO1xuICAgICAgICBsZXQgZXNjYXBlICA9IGZhbHNlO1xuXG4gICAgICAgIGZvciAoIGxldCBpID0gMDsgaSA8IHN0cmluZy5sZW5ndGg7IGkrKyApIHtcbiAgICAgICAgICAgIGxldCBsZXR0ZXIgPSBzdHJpbmdbaV07XG5cbiAgICAgICAgICAgIGlmICggcXVvdGUgKSB7XG4gICAgICAgICAgICAgICAgaWYgKCBlc2NhcGUgKSB7XG4gICAgICAgICAgICAgICAgICAgIGVzY2FwZSA9IGZhbHNlO1xuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoIGxldHRlciA9PT0gJ1xcXFwnICkge1xuICAgICAgICAgICAgICAgICAgICBlc2NhcGUgPSB0cnVlO1xuICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoIGxldHRlciA9PT0gcXVvdGUgKSB7XG4gICAgICAgICAgICAgICAgICAgIHF1b3RlID0gZmFsc2U7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfSBlbHNlIGlmICggbGV0dGVyID09PSAnXCInIHx8IGxldHRlciA9PT0gJ1xcJycgKSB7XG4gICAgICAgICAgICAgICAgcXVvdGUgPSBsZXR0ZXI7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKCBsZXR0ZXIgPT09ICcoJyApIHtcbiAgICAgICAgICAgICAgICBmdW5jICs9IDE7XG4gICAgICAgICAgICB9IGVsc2UgaWYgKCBsZXR0ZXIgPT09ICcpJyApIHtcbiAgICAgICAgICAgICAgICBpZiAoIGZ1bmMgPiAwICkgZnVuYyAtPSAxO1xuICAgICAgICAgICAgfSBlbHNlIGlmICggZnVuYyA9PT0gMCApIHtcbiAgICAgICAgICAgICAgICBpZiAoIHNlcGFyYXRvcnMuaW5kZXhPZihsZXR0ZXIpICE9PSAtMSApIHNwbGl0ID0gdHJ1ZTtcbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgaWYgKCBzcGxpdCApIHtcbiAgICAgICAgICAgICAgICBpZiAoIGN1cnJlbnQgIT09ICcnICkgYXJyYXkucHVzaChjdXJyZW50LnRyaW0oKSk7XG4gICAgICAgICAgICAgICAgY3VycmVudCA9ICcnO1xuICAgICAgICAgICAgICAgIHNwbGl0ICAgPSBmYWxzZTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgY3VycmVudCArPSBsZXR0ZXI7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoIGxhc3QgfHwgY3VycmVudCAhPT0gJycgKSBhcnJheS5wdXNoKGN1cnJlbnQudHJpbSgpKTtcbiAgICAgICAgcmV0dXJuIGFycmF5O1xuICAgIH0sXG5cbiAgICAvKipcbiAgICAgKiBTYWZlbHkgc3BsaXRzIHNwYWNlLXNlcGFyYXRlZCB2YWx1ZXMgKHN1Y2ggYXMgdGhvc2UgZm9yIGBiYWNrZ3JvdW5kYCxcbiAgICAgKiBgYm9yZGVyLXJhZGl1c2AsIGFuZCBvdGhlciBzaG9ydGhhbmQgcHJvcGVydGllcykuXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gc3RyaW5nIC0gc3BhY2Utc2VwYXJhdGVkIHZhbHVlc1xuICAgICAqXG4gICAgICogQHJldHVybiB7c3RyaW5nW119IHNwbGl0IHZhbHVlc1xuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBwb3N0Y3NzLmxpc3Quc3BhY2UoJzFweCBjYWxjKDEwJSArIDFweCknKSAvLz0+IFsnMXB4JywgJ2NhbGMoMTAlICsgMXB4KSddXG4gICAgICovXG4gICAgc3BhY2Uoc3RyaW5nKSB7XG4gICAgICAgIGxldCBzcGFjZXMgPSBbJyAnLCAnXFxuJywgJ1xcdCddO1xuICAgICAgICByZXR1cm4gbGlzdC5zcGxpdChzdHJpbmcsIHNwYWNlcyk7XG4gICAgfSxcblxuICAgIC8qKlxuICAgICAqIFNhZmVseSBzcGxpdHMgY29tbWEtc2VwYXJhdGVkIHZhbHVlcyAoc3VjaCBhcyB0aG9zZSBmb3IgYHRyYW5zaXRpb24tKmBcbiAgICAgKiBhbmQgYGJhY2tncm91bmRgIHByb3BlcnRpZXMpLlxuICAgICAqXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IHN0cmluZyAtIGNvbW1hLXNlcGFyYXRlZCB2YWx1ZXNcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge3N0cmluZ1tdfSBzcGxpdCB2YWx1ZXNcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcG9zdGNzcy5saXN0LmNvbW1hKCdibGFjaywgbGluZWFyLWdyYWRpZW50KHdoaXRlLCBibGFjayknKVxuICAgICAqIC8vPT4gWydibGFjaycsICdsaW5lYXItZ3JhZGllbnQod2hpdGUsIGJsYWNrKSddXG4gICAgICovXG4gICAgY29tbWEoc3RyaW5nKSB7XG4gICAgICAgIGxldCBjb21tYSA9ICcsJztcbiAgICAgICAgcmV0dXJuIGxpc3Quc3BsaXQoc3RyaW5nLCBbY29tbWFdLCB0cnVlKTtcbiAgICB9XG5cbn07XG5cbmV4cG9ydCBkZWZhdWx0IGxpc3Q7XG4iXX0=
