var test = require('tape');
var path = require('path');
var home = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];
var homedir = require('./index');

test('homedir()', function (t) {
  var user = path.basename(home);
  var match = new RegExp(user + '$');

  t.ok(homedir().match(match));
  t.end();
});

test('homedir("guest")', function (t) {
  var user = "guest";
  var match = new RegExp(user + '$');

  t.ok(homedir(user).match(match));
  t.end();
});

