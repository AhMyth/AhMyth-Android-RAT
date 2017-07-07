'use strict';

/**
 * Regular expression for matching CSS @imports
 *
 * @param {Object} opts
 * @api public
 */

module.exports = function (opts) {
	opts = opts || {};

	var regex = '(?:@import)(?:\\s)(?:url)?(?:(?:(?:\\()(["\'])?(?:[^"\')]+)\\1(?:\\))|(["\'])(?:.+)\\2)(?:[A-Z\\s])*)+(?:;)';

	return opts.exact ? new RegExp('(?:^' + regex + '$)', 'i') :
						new RegExp('(?:^|\\s)?' + regex, 'gi');
};
