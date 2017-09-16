var path = require('path');

/**
 * Flatten the path to the desired depth
 *
 * @param {File} file - vinyl file
 * @param {Object} options
 * @return {String}
 */
function flattenPath(file, opts) {
  var topLevels;
  var bottomLevels = 0;
  var dirs;
  var topPath = [];
  var bottomPath = [];
  var newPath = [];
  var fileName = path.basename(file.path);

  if (!opts.includeParents) {
    return fileName;
  }

  opts = opts.includeParents;
  if (Array.isArray(opts)) {
    topLevels = Math.abs(opts[0]);
    bottomLevels = Math.abs(opts[1]);
  } else if (opts >= 0) {
    topLevels = opts;
  } else {
    bottomLevels = Math.abs(opts);
  }

  dirs = path.dirname(file.relative).split(path.sep);
  if (topLevels + bottomLevels > dirs.length) {
    return file.relative;
  }

  while (topLevels > 0) {
    topPath.push(dirs.shift());
    topLevels--;
  }
  while (bottomLevels > 0) {
    bottomPath.unshift(dirs.pop());
    bottomLevels--;
  }
  newPath = topPath.concat(bottomPath);
  newPath.push(fileName);

  return path.join.apply(path, newPath);
}


module.exports = flattenPath
