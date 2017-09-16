# import-regex [![Build Status](https://travis-ci.org/kevva/import-regex.svg?branch=master)](https://travis-ci.org/kevva/import-regex)

> Regular expression for matching CSS @imports

## Install

```sh
$ npm install --save import-regex
```

## Usage

```js
var importRegex = require('import-regex');

importRegex().test('@import url(\'foo.css\'); foo bar');
//=> true

importRegex({ exact: true }).test('@import url(\'foo.css\'); foo bar');
//=> false

importRegex({ exact: true }).test('@import url(\'foo.css\');');
//=> true

'foo @import url(\'foo.css\'); bar @import url(\'bar.css\');'.match(importRegex());
//=> ['@import url('foo.css');', '@import url('bar.css');']
```

## License

MIT © [Kevin Mårtensson](http://kevinmartensson.com)
