'use strict';

exports.__esModule = true;
/**
 * Contains helpers for working with vendor prefixes.
 *
 * @example
 * const vendor = postcss.vendor;
 *
 * @namespace vendor
 */
var vendor = {

    /**
     * Returns the vendor prefix extracted from an input string.
     *
     * @param {string} prop - string with or without vendor prefix
     *
     * @return {string} vendor prefix or empty string
     *
     * @example
     * postcss.vendor.prefix('-moz-tab-size') //=> '-moz-'
     * postcss.vendor.prefix('tab-size')      //=> ''
     */
    prefix: function prefix(prop) {
        var match = prop.match(/^(-\w+-)/);
        if (match) {
            return match[0];
        } else {
            return '';
        }
    },


    /**
     * Returns the input string stripped of its vendor prefix.
     *
     * @param {string} prop - string with or without vendor prefix
     *
     * @return {string} string name without vendor prefixes
     *
     * @example
     * postcss.vendor.unprefixed('-moz-tab-size') //=> 'tab-size'
     */
    unprefixed: function unprefixed(prop) {
        return prop.replace(/^-\w+-/, '');
    }
};

exports.default = vendor;
module.exports = exports['default'];
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9saWIvdmVuZG9yLmVzNiJdLCJuYW1lcyI6WyJ2ZW5kb3IiLCJwcmVmaXgiLCJwcm9wIiwibWF0Y2giLCJ1bnByZWZpeGVkIiwicmVwbGFjZSJdLCJtYXBwaW5ncyI6Ijs7O0FBQUE7Ozs7Ozs7O0FBUUEsSUFBSUEsU0FBUzs7QUFFVDs7Ozs7Ozs7Ozs7QUFXQUMsVUFiUyxrQkFhRkMsSUFiRSxFQWFJO0FBQ1QsWUFBSUMsUUFBUUQsS0FBS0MsS0FBTCxDQUFXLFVBQVgsQ0FBWjtBQUNBLFlBQUtBLEtBQUwsRUFBYTtBQUNULG1CQUFPQSxNQUFNLENBQU4sQ0FBUDtBQUNILFNBRkQsTUFFTztBQUNILG1CQUFPLEVBQVA7QUFDSDtBQUNKLEtBcEJROzs7QUFzQlQ7Ozs7Ozs7Ozs7QUFVQUMsY0FoQ1Msc0JBZ0NFRixJQWhDRixFQWdDUTtBQUNiLGVBQU9BLEtBQUtHLE9BQUwsQ0FBYSxRQUFiLEVBQXVCLEVBQXZCLENBQVA7QUFDSDtBQWxDUSxDQUFiOztrQkFzQ2VMLE0iLCJmaWxlIjoidmVuZG9yLmpzIiwic291cmNlc0NvbnRlbnQiOlsiLyoqXG4gKiBDb250YWlucyBoZWxwZXJzIGZvciB3b3JraW5nIHdpdGggdmVuZG9yIHByZWZpeGVzLlxuICpcbiAqIEBleGFtcGxlXG4gKiBjb25zdCB2ZW5kb3IgPSBwb3N0Y3NzLnZlbmRvcjtcbiAqXG4gKiBAbmFtZXNwYWNlIHZlbmRvclxuICovXG5sZXQgdmVuZG9yID0ge1xuXG4gICAgLyoqXG4gICAgICogUmV0dXJucyB0aGUgdmVuZG9yIHByZWZpeCBleHRyYWN0ZWQgZnJvbSBhbiBpbnB1dCBzdHJpbmcuXG4gICAgICpcbiAgICAgKiBAcGFyYW0ge3N0cmluZ30gcHJvcCAtIHN0cmluZyB3aXRoIG9yIHdpdGhvdXQgdmVuZG9yIHByZWZpeFxuICAgICAqXG4gICAgICogQHJldHVybiB7c3RyaW5nfSB2ZW5kb3IgcHJlZml4IG9yIGVtcHR5IHN0cmluZ1xuICAgICAqXG4gICAgICogQGV4YW1wbGVcbiAgICAgKiBwb3N0Y3NzLnZlbmRvci5wcmVmaXgoJy1tb3otdGFiLXNpemUnKSAvLz0+ICctbW96LSdcbiAgICAgKiBwb3N0Y3NzLnZlbmRvci5wcmVmaXgoJ3RhYi1zaXplJykgICAgICAvLz0+ICcnXG4gICAgICovXG4gICAgcHJlZml4KHByb3ApIHtcbiAgICAgICAgbGV0IG1hdGNoID0gcHJvcC5tYXRjaCgvXigtXFx3Ky0pLyk7XG4gICAgICAgIGlmICggbWF0Y2ggKSB7XG4gICAgICAgICAgICByZXR1cm4gbWF0Y2hbMF07XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICByZXR1cm4gJyc7XG4gICAgICAgIH1cbiAgICB9LFxuXG4gICAgLyoqXG4gICAgICogUmV0dXJucyB0aGUgaW5wdXQgc3RyaW5nIHN0cmlwcGVkIG9mIGl0cyB2ZW5kb3IgcHJlZml4LlxuICAgICAqXG4gICAgICogQHBhcmFtIHtzdHJpbmd9IHByb3AgLSBzdHJpbmcgd2l0aCBvciB3aXRob3V0IHZlbmRvciBwcmVmaXhcbiAgICAgKlxuICAgICAqIEByZXR1cm4ge3N0cmluZ30gc3RyaW5nIG5hbWUgd2l0aG91dCB2ZW5kb3IgcHJlZml4ZXNcbiAgICAgKlxuICAgICAqIEBleGFtcGxlXG4gICAgICogcG9zdGNzcy52ZW5kb3IudW5wcmVmaXhlZCgnLW1vei10YWItc2l6ZScpIC8vPT4gJ3RhYi1zaXplJ1xuICAgICAqL1xuICAgIHVucHJlZml4ZWQocHJvcCkge1xuICAgICAgICByZXR1cm4gcHJvcC5yZXBsYWNlKC9eLVxcdystLywgJycpO1xuICAgIH1cblxufTtcblxuZXhwb3J0IGRlZmF1bHQgdmVuZG9yO1xuIl19
