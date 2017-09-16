# get-imports [![Build Status](https://travis-ci.org/kevva/get-imports.svg?branch=master)](https://travis-ci.org/kevva/get-imports)

> Get CSS @imports from a string

## Install

```sh
$ npm install --save get-imports
```

## Usage

```js
var getImports = require('get-imports');
var str = '@import url(\'foo.css\'); foo @import url(\'bar.css\'); bar';

getImports(str);
//=> ['@import url('foo.css');', '@import url('bar.css');']
```

## License

MIT © [Kevin Mårtensson](http://kevinmartensson.com)
