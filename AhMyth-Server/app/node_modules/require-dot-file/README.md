##  Install

```javascript
npm install require-dot-file
```

## Usage

This is a simple module used for recursively searching across all parent folders for a file to require.

For example you may want to allow a user to [include a dotfile](http://askubuntu.com/questions/94780/what-are-dot-files) to allow users to configure your project that they can include in their project root.

```javascript
var
  requireDotFile = require('require-dot-file')
;

// searches for .myconfig in all parent dir recursively (including current dir)
var config = requireDotFile('.myconfig');

// searches for .myconfig file in /path/to/start and its parent dirs
var config = requireDotFile('.myconfig', '/path/to/start');
```