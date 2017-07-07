# [gulp](http://gulpjs.com)-flatten [![NPM version](https://img.shields.io/npm/v/gulp-flatten.svg)](http://badge.fury.io/js/gulp-flatten) [![Build Status](https://api.travis-ci.org/armed/gulp-flatten.svg?branch=master)](https://travis-ci.org/armed/gulp-flatten)

>Remove or replace relative path for files (gulp v3).

## Install

```
npm install gulp-flatten
```

## Usage

Example source directory with bower compoments:
```
├── angular
│   ├── README.md
│   ├── angular-csp.css
│   ├── angular.js
│   ├── angular.min.js
│   └── bower.json
├── angular-route
│   ├── README.md
│   ├── angular-route.js
│   ├── angular-route.min.js
│   ├── angular-route.min.js.map
│   └── bower.json
├── angular-sanitize
│   ├── README.md
│   ├── angular-sanitize.js
│   ├── angular-sanitize.min.js
│   ├── angular-sanitize.min.js.map
│   └── bower.json
└── bootstrap
    ├── DOCS-LICENSE
    ├── LICENSE
    ├── LICENSE-MIT
    ├── README.md
    ├── bower.json
    └── dist
        ├── css
        │   ├── bootstrap-theme.css
        │   ├── bootstrap-theme.min.css
        │   ├── bootstrap.css
        │   └── bootstrap.min.css
        ├── fonts
        │   ├── glyphicons-halflings-regular.eot
        │   ├── glyphicons-halflings-regular.svg
        │   ├── glyphicons-halflings-regular.ttf
        │   └── glyphicons-halflings-regular.woff
        └── js
            ├── bootstrap.js
            └── bootstrap.min.js
```

By default `gulp` stores files with it's relative paths. To copy all minified javascript files from `bower_components` to `build` folder without relative paths:
```js
var flatten = require('gulp-flatten');

gulp.src('bower_components/**/*.min.js')
  .pipe(flatten())
  .pipe(gulp.dest('build/js'));
```

Result will be list of all `.min.js` files inside `build/js` dir:
```
build
└── js
    ├── angular-route.min.js
    ├── angular-sanitize.min.js
    ├── angular.min.js
    └── bootstrap.min.js
```

## Options

### flatten(options)

#### options.newPath

Type: `String`  
Default: `''`

Relative path for file.

#### options.includeParents

Type: `Number` or `Array` of two numbers

If passed in as positive number, it will include the number of top-level parents in the output. Using this code:

```js
gulp.src(['bower_components/**/*.css'])
  .pipe(flatten({ includeParents: 1} ))
  .pipe(gulp.dest('build/'));
```

will create this structure (from sample directory tree above):

```
└── bootstrap
    ├── bootstrap-theme.css
    ├── bootstrap-theme.min.css
    ├── bootstrap.css
    ├── bootstrap.min.css
    └── bootstrap.min.js
```

If passed in as negative number, it will include the number of bottom-level parents in the output. Using this code:

```js
gulp.src(['bower_components/**/*.css'])
  .pipe(flatten({ includeParents: -1} )) //or indludeParents: [0, 1]
  .pipe(gulp.dest('build/'));
```

will create this structure:

```
└── css
    ├── bootstrap-theme.css
    ├── bootstrap-theme.min.css
    ├── bootstrap.css
    ├── bootstrap.min.css
    └── bootstrap.min.js
```

If passes as array of two numbers, both parents from top and bottom will be kept in resulting path of a file.

```js
gulp.src(['bower_components/**/*.css'])
  .pipe(flatten({ includeParents: [1, 1]} ))
  .pipe(gulp.dest('build/'));
```

will create this structure:

```
└── bootstrap
    └── css
        ├── bootstrap-theme.css
        ├── bootstrap-theme.min.css
        ├── bootstrap.css
        └── bootstrap.min.css
```

## License

MIT
