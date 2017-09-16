# rework-import [![Build Status](http://img.shields.io/travis/reworkcss/rework-import.svg?style=flat)](https://travis-ci.org/reworkcss/rework-import)

> Import stylesheets using `@import` and an optional media query


## Install

```bash
$ npm install --save rework-import
```


## Usage

```js
var data = require('fs').readFileSync('index.css');
var imprt = require('rework-import');
var rework = require('rework');

rework(data)
	.use(imprt({path: 'app/stylesheets'}))
	.toString();
```


## Options

### encoding

Type: `String`  
Default: `utf8`

Use if your CSS is encoded in anything other than `UTF-8`.

### path

Type: `Array|String`  
Default: `process.cwd()` or `__dirname` of [the rework source](https://github.com/reworkcss/css#cssparsecode-options)

A string or an array of paths in where to look for files.

_Note: nested `@import` will additionally benefit of the relative dirname of imported files._

### transform

Type: `Function`  

A function to transform the content of imported files. Takes one argument and should return the modified content. Useful if you use [`css-whitespace`](https://github.com/reworkcss/css-whitespace).

## Example

```css
@import 'foo.css' (min-width: 25em);

body {
	background: black;
}
```

yields:

```css
@media (min-width: 25em) {
	body {
		background: red;
	}

	h1 {
		color: grey;
	}
}

body {
	background: black;
}
```


## License

MIT © [Jason Campbell](https://github.com/jxson) and [Kevin Mårtensson](http://github.com/kevva)
