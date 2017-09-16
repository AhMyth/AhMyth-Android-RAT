Indx
----

[![npm](http://img.shields.io/npm/v/indx.svg?style=flat)](https://badge.fury.io/js/indx) [![tests](http://img.shields.io/travis/jenius/indx/master.svg?style=flat)](https://travis-ci.org/jenius/indx) [![coverage](http://img.shields.io/coveralls/jenius/indx.svg?style=flat)](https://coveralls.io/r/jenius/indx) [![dependencies](http://img.shields.io/gemnasium/jenius/indx.svg?style=flat)](https://gemnasium.com/jenius/indx)

Require a folder of files or other folders, instead of doing them one at a time.

> **Note:** This project is in development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

So let's say you are setting up a node project, and using the [adapter pattern](http://en.wikipedia.org/wiki/Adapter_pattern), which is a great and useful pattern. You may have a folder full of adapters, and you want to require all of them into an object, rather than going through each one individually. Kind of like [require_tree in sprockets](https://github.com/sstephenson/sprockets#the-require_tree-directive). That's exactly what indx does for you.

It's a very small script, but it's something I found myself writing and re-writing, so I figured why not wrap it up and give it to the world to make life a couple lines of code shorter.

### Installation

`npm install indx`

### Usage

In the folder you want to require, put an `index.js` file at the root. Inside that file, write this:

```js
module.exports = require('indx')(__dirname);
```

This you can require that folder and each of the files will be present. Alternately, just pass `indx` the path of a directory you want to require:

```js
var adapters = require('indx')('./adapters')
```

The path you pass will be passed through [path.resolve](http://nodejs.org/api/path.html#path_path_resolve_from_to), so no need to compute an absolute path if you don't need to. The example above will work fine without having to run any additional `path` methods on it as long as the relative path there is correct.

Indx supports javascript and coffeescript. If you have folders inside your folder, make sure each of those folders has an `index.js` or `index.coffee` file in it, or it won't be required. If you have files in your folder that are not `.js` or `.coffee`, they will not be required. If there are other languages I'm not aware of you'd like to add support for, feel free to submit a pull request - it's easy to extend the supported extensions.

### License & Contributing

This project is licensed under [MIT](license.md)

This entire project is one file, pretty easy to figure out how it's working. If you want to add something or fix a bug, please add a test for it. You can run tests with `mocha` in the root of the project.
