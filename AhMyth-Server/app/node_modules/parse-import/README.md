# parse-import [![Build Status](http://img.shields.io/travis/kevva/parse-import.svg?style=flat)](https://travis-ci.org/kevva/parse-import)

> Parse CSS `@import` statements.

## Install

```sh
$ npm install --save parse-import
```

## Usage

```js
var parseImport = require('parse-import');
var str = [
	'@import url("foo.css");',
	'@import "bar.css" only screen and (min-width: 25em);'
].join(' ');

parseImport(str);

/*
[{ 
	path: 'foo.css', 
	condition: '',
	rule: '@import url("foo.css")'
}, { 
	path: 'bar.css', 
	condition: 'only screen and (min-width: 25em)',
	rule: '@import "bar.css" only screen and (min-width: 25em)'
}]
 */
```

## License

MIT © [Kevin Mårtensson](https://github.com/kevva)
