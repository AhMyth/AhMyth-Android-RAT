// references

var path = require('path');
var home = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

// exports

module.exports = homedir;

/**
 * Resolves the path to the user's home directory.
 *
 * @param {String} [username]
 * Username of user whose path you seek.
 *
 * @return {String}
 * The full path to the user's home directory.
 */

function homedir(username) {
  return username ? path.resolve(path.dirname(home), username) : home;
}

