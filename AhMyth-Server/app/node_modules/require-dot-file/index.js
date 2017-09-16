var
  fs              = require('fs'),
  path            = require('path')
;

// walks parent folders until a dot file is found
module.exports = function(file, directory, maxSteps) {
  var
    steps = 0,
    requirePath,
    walk
  ;

  // recursion safety-net
  maxSteps = maxSteps || 20;

  walk = function(directory) {
    var
      nextDirectory = path.resolve( path.join(directory, path.sep, '..') ),
      currentPath   = path.normalize( path.join(directory, file) )
    ;
    if( fs.existsSync(currentPath) ) {
      // found file
      requirePath = path.normalize(currentPath);
      return;
    }
    else {
      // reached file system root, let's stop
      if(nextDirectory == directory || steps >= maxSteps ) {
        return;
      }
      // otherwise recurse
      steps++;
      walk(nextDirectory, file);
    }
  };

  // start walk from outside require-dot-files directory
  directory = directory || path.join(__dirname, path.sep , '..');
  walk(directory);

  if(!requirePath) {
    // throw new Error('Unable to find: ' + file);
    return false;
  }
  return require(requirePath);

};