'use strict';

var arrayUniq = require('array-uniq');
var importRegex = require('import-regex');

/**
 * Get CSS @imports from a string
 *
 * @param {String} str
 * @api public
 */

module.exports = function (str) {
	var imports = str.match(importRegex());

	if (!imports) {
		return [];
	}

	return arrayUniq(imports.map(function (el) {
		return el.trim();
	}));
};
