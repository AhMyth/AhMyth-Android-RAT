accord
======

[![npm](https://img.shields.io/npm/v/accord.svg?style=flat)](http://badge.fury.io/js/accord)
[![tests](https://img.shields.io/travis/jescalan/accord/master.svg?style=flat)](https://travis-ci.org/jescalan/accord)
[![coverage](https://img.shields.io/coveralls/jescalan/accord/master.svg?style=flat)](https://coveralls.io/r/jescalan/accord?branch=master)
[![dependencies](https://img.shields.io/david/jescalan/accord.svg?style=flat)](https://david-dm.org/jescalan/accord)

A unified interface for compiled languages and templates in JavaScript.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

There are two other libraries that already attempt to provide a common compiler interface: [consolidate.js](https://github.com/tj/consolidate.js) and [JSTransformers](https://github.com/jstransformers/jstransformer). After reviewing & using both of them, we designed accord to provide a more maintainable code base and way of writing adapters.

Accord:

- Uses standard JavaScript inheritance (aka: classes in CoffeeScript) in its adapters
- Supports source maps
- Lets you use any major version of an adapter

### Installation

`npm install accord`

### Usage

Accord itself exposes only a JavaScript API. If you are interested in using this library from the command line, check out the [accord-cli](https://github.com/carrot/accord-cli) project.

Since some templating engines are async and others are not, accord keeps things consistent by returning a promise for any task (using [when.js](https://github.com/cujojs/when)). Here's an example in CoffeeScript:

```coffee
fs = require 'fs'
accord = require 'accord'
jade = accord.load('jade')

# render a string
jade.render('body\n  .test')
  .done(console.log.bind(console))

# or a file
jade.renderFile('./example.jade')
  .done(console.log.bind(console))

# or compile a string to a function
# (only some to-html compilers support this, see below)
jade.compile('body\n  .test')
  .done(console.log.bind(console))

# or a file
jade.compileFile('./example.jade')
  .done(console.log.bind(console))

# compile a client-side js template
jade.compileClient('body\n  .test')
  .done (res) -> console.log(res.result.toString())

# or a file
jade.compileFileClient('./example.jade')
  .done (res) -> console.log(res.result.toString())

```

It's also important to note that accord returns an object rather than a string from each of these methods. You can access the compiled result on the `result` property of this object. If the adapter supports source maps, the source map will also be on this object if you have passed in the correct options. Docs below should explain the methods executed in the example above.

### Accord Methods

- `accord.load(string, object)` - loads the compiler named in the first param, npm package with the name must be installed locally, or the optional second param must be the compiler you are after. The second param allows you to load the compiler from elsewhere or load an alternate version if you want, but be careful.

- `accord.supports(string)` - quick test to see if accord supports a certain compiler. accepts a string, which is the name of language (like markdown) or a compiler (like marked), returns a boolean.

### Accord Adapter Methods

- `adapter.name`
- `adapter.render(string, options)` - render a string to a compiled string
- `adapter.renderFile(path, options)` - render a file to a compiled string
- `adapter.compile(string, options)` - compile a string to a function
- `adapter.compileFile(path, options)` - compile a file to a function
- `adapter.compileClient(string, options)` - compile a string to a client-side-ready function
- `adapter.compileFileClient(string, options)` - compile a file to a client-side-ready function
- `adapter.clientHelpers()` - some adapters that compile for client also need helpers, this method returns a string of minfied JavaScript with all of them
- `adapter.extensions` - array of all file extensions the compiler should match
- `adapter.output` - string, expected output extension
- `adapter.engine` - the actual compiler, no adapter wrapper, if you need it

### Supported Languages

#### HTML

- [jade](http://jade-lang.com/)
- [eco](https://github.com/sstephenson/eco)
- [ejs](https://github.com/tj/ejs)
- [markdown](https://github.com/chjj/marked)
- [mustache/hogan](https://github.com/twitter/hogan.js)
- [handlebars](https://github.com/wycats/handlebars.js)
- [haml](https://github.com/tj/haml.js)
- [swig](http://paularmstrong.github.io/swig)
- [marc](https://github.com/bredele/marc)
- [toffee](https://github.com/malgorithms/toffee)
- [doT.js](https://github.com/olado/doT)

#### CSS

- [stylus](http://learnboost.github.io/stylus/)
- [scss](https://github.com/sass/node-sass)
- [less](https://github.com/less/less.js/)
- [myth](https://github.com/segmentio/myth)
- [postcss](https://github.com/postcss/postcss)

#### JavaScript

- [coffeescript](http://coffeescript.org/)
- [dogescript](https://github.com/dogescript/dogescript)
- [coco](https://github.com/satyr/coco)
- [livescript](https://github.com/gkz/LiveScript)
- [babel](https://github.com/babel/babel)
- [jsx](https://github.com/facebook/react)
- [cjsx](https://github.com/jsdf/coffee-react-transform)
- [typescript](http://www.typescriptlang.org/)
- [buble](https://buble.surge.sh/guide/)

#### Minifiers

- [minify-js](https://github.com/mishoo/UglifyJS2)
- [minify-css](https://github.com/jakubpawlowicz/clean-css)
- [minify-html](https://github.com/kangax/html-minifier)
- [csso](https://github.com/css/csso)

#### Escapers

- [escape-html](https://github.com/mathiasbynens/he)

### Evergreen Version Support

As of version `0.20.0`, accord ships with a system that can be used to offer full support for any engine across any version, so that the interface remains consistent even in the face of breaking changes to the adapter's API. With this feature in place, you can freely upgrade accord without worrying about any breakage in any libraries you are using, ever.

So for example, if you are using sass and they release a breaking version bump, we will release a new adapter for the new version and cut a new release of accord that includes support for this version. However, if you are still using the old version, it will still work as before so you have as much time as you need to upgrade to the new version.

This does not mean that we immediately support every version of every library infinitely into the past. However, going forward, we will support any new updates to libraries from now on to ensure that nothing breaks for users.

This is a feature that is unique to accord and we are beyond excited to make it available to everyone.

### Languages Supporting Compilation

Accord can also compile templates into JavaScript functions, for some languages. This is really useful for client-side rendering. Languages with compile support are listed below. If you try to compile a language without support for it, you will get an error.

- jade
- ejs
- handlebars
- mustache

We are always looking to add compile support for more languages, but it can be difficult, as client-side template support isn't always the first thing on language authors' minds. Any contributions that help to expand this list are greatly appreciated!

When using a language supporting client-side templates, make sure to check the [docs](docs) for that language for more details. In general, you'll get back a stringified function from the `compileClient` or `compileFileClient` methods, and a string of client helpers from the `clientHelpers` methods. You can take these, organize them, and write them to files however you wish. Usually the best way is to write the helpers to a file first, then iterate through each of the client-compiled functions, assigning them a name so they can be accessed later on.

### Adding Languages

Want to add more languages? We have put extra effort into making the adapter pattern structure understandable and easy to add to and test. Rather than requesting that a language be added, please add a pull request and add it yourself! We are quite responsive and will quickly accept if the implementation is well-tested.

Details on running tests and contributing [can be found here](contributing.md)

### Source Maps

Accord now supports source map generation for any language that also supports source maps. At the moment, this includes the following languages:

- stylus
- less
- myth
- scss
- coffeescript
- minify-js
- 6to5
- postcss

Accord returns all source maps as javascript objects, and if available will prefer a [v3 sourcemap](https://docs.google.com/document/d/1U1RGAehQwRypUTovF1KRlpiOFze0b-_2gc6fAH0KY0k/edit) over any other format. You can find the primary sourcemap on the object returned from accord under the `sourcemap` key. If there are multiple sourcemaps generated, alternate ones will be avaiable under different keys, which you can find on the object returned from accord after a compile.

To generate a sourcemap, you can pass `sourcemap: true` as an option to any compiler and you will get back a sourcemap with the file names, sources, and mappings correctly specified, guaranteed. Each compiler also has it's own way of specifying source map options. If you'd like to dive into those details to customize the output, you are welcome to do so, but it is at your own risk.

If there is a language that now supports sourcemaps and you'd like support for them to be added, get a pull request going and we'll make it happen!

### License

Licensed under [MIT](license.md)
