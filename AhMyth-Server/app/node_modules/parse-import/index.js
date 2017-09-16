'use strict';

var getImports = require('get-imports');

/**
 * Get path from @import
 *
 * @param {String} str
 * @api private
 */

function path(str) {
	return /(?:url\()(?:.*?)(?:\))|(["\'])(?:[^"\')]+)\1/ig.exec(str)[0]
		.replace(/(?:url\()/ig, '')
		.replace(/(?:\))/g, '')
		.replace(/(?:["\'])/g, '')
		.trim();
}

/**
 * Get condition from @import
 *
 * @param {String} str
 * @api private
 */

function condition(str) {
	return str.replace(/(?:url\()(?:.*?)(?:\))|(["\'])(?:[^"\')]+)\1/ig, '')
		.replace(/(?:@import)(?:\s)*/g, '')
		.trim();
}

/**
 * Parse @import statements
 *
 * @param {String} str
 * @api public
 */

module.exports = function (str) {
	var imports = getImports(str);

	return imports.map(function (imp) {
		imp = imp.replace(/(?:;)$/g, '');

		return {
			path: path(imp),
			condition: condition(imp),
			rule: imp
		};
	});
};
