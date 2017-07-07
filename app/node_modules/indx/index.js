var fs = require('fs'),
    path = require('path');

var valid_extensions = ['js', 'coffee'];

module.exports = function(dir){
  dir = path.resolve(dir);
  var res = {};
  var objs = fs.readdirSync(dir)
               // ignore index file
               .filter(function(f){ return f.match(/^index\./) ? false : true })
               // ignore non-js files that aren't folders
               .filter(function(f){ return isDir(dir,f) || f.match(extensions_regex()) ? true : false })
               // ignore folders without an index file
               .filter(function(f){ return (isDir(dir,f) && !contains_index(dir,f)) ? false : true })
               // remove extensions
               .map(function(f){ return f.replace(extensions_regex(), '') });

  objs.forEach(function(obj){
    try {
      res[obj] = require(path.join(dir, obj));
    } catch (err) {
      err.message = "Could note require " + path.join(dir, obj) + ": " + err.message
      throw err
    }
  });

  return res;
}

//
// @api private
//

function isDir(dir, f){ return fs.statSync(path.join(dir,f)).isDirectory() }

function extensions_regex(){
  var str = '';
  valid_extensions.forEach(function(ext){ str += '\\.' + ext + '$' + '|'; });
  return new RegExp(str.slice(0,-1))
}

function contains_index(dir,f){
  var res = false;
  valid_extensions.forEach(function(ext){
    if (fs.existsSync(path.join(dir, f, 'index.' + ext))) { res = true; }
  });
  return res;
}
