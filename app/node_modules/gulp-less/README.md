# gulp-less


> A [LESS](http://lesscss.org/) plugin for Gulp

[![NPM Version](https://img.shields.io/npm/v/gulp-less.svg)](https://www.npmjs.com/package/gulp-less)
[![Build Status](https://img.shields.io/travis/plus3network/gulp-less.svg)](https://travis-ci.org/plus3network/gulp-less)

## Information

<table>
<tr>
<td>Package</td><td>gulp-less</td>
</tr>
<tr>
<td>Description</td>
<td>Less plugin for gulp</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.10</td>
</tr>
<tr>
<td>Less Version</td>
<td>>= 2.x</td>
</tr>
<tr>
<td>Gulp Version</td>
<td>3.x</td>
</tr>
</table>

## Installation

```
npm install gulp-less
```

## Basic Usage

```js
var less = require('gulp-less');
var path = require('path');

gulp.task('less', function () {
  return gulp.src('./less/**/*.less')
    .pipe(less({
      paths: [ path.join(__dirname, 'less', 'includes') ]
    }))
    .pipe(gulp.dest('./public/css'));
});
```

## Options

The options you can use [can be found here](http://lesscss.org/#using-less-configuration). Below is a list of valid options as of the time of writing:

- `paths`: Array of paths to be used for `@import` directives
- `plugins`: Array of less plugins ([details](#using-plugins))

The `filename` option is not necessary, it's handled automatically by this plugin. The `compress` option is not supported -- if you are trying to minify your css, use a css minifier. No `sourceMap` options are supported -- if you are trying to generate sourcemaps, use [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps).

## Using Plugins

Less now supports plugins, which can add additional functionality. Here's an example of how to use a plugin with `gulp-less`.

```js
var LessAutoprefix = require('less-plugin-autoprefix');
var autoprefix = new LessAutoprefix({ browsers: ['last 2 versions'] });

return gulp.src('./less/**/*.less')
  .pipe(less({
    plugins: [autoprefix]
  }))
  .pipe(gulp.dest('./public/css'));
```

More info on LESS plugins can be found at http://lesscss.org/usage/#plugins, including a current list of all available plugins.

## Source Maps

`gulp-less` can be used in tandem with [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps) to generate source maps for your files. You will need to initialize [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps) prior to running the gulp-less compiler and write the source maps after, as such:

```js
var sourcemaps = require('gulp-sourcemaps');

gulp.src('./less/**/*.less')
  .pipe(sourcemaps.init())
  .pipe(less())
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('./public/css'));
```

By default, [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps) writes the source maps inline in the compiled CSS files. To write them to a separate file, specify a relative file path in the `sourcemaps.write()` function, as such:

```js
var sourcemaps = require('gulp-sourcemaps');

gulp.src('./less/**/*.less')
  .pipe(sourcemaps.init())
  .pipe(less())
  .pipe(sourcemaps.write('./maps'))
  .pipe(gulp.dest('./public/css'));
```

## Error Handling

By default, a gulp task will fail and all streams will halt when an error happens. To change this behavior check out the error handling documentation [here](https://github.com/gulpjs/gulp/blob/master/docs/recipes/combining-streams-to-handle-errors.md)

## License

(MIT License)

Copyright (c) 2015 Plus 3 Network dev@plus3network.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
