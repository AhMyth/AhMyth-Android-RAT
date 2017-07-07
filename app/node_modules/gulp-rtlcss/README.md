# gulp-rtlcss

[![MIT Licence][licence-image]][licence-url] [![NPM Version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Dependency Status][david-dm-image]][david-dm-url]

[Gulp](http://gulpjs.com) plugin that uses [RTLCSS](https://github.com/MohammadYounes/rtlcss) to convert LTR CSS to RTL.

## Install

```bash
$ npm install --save-dev gulp-rtlcss
```

## Basic Usage

```js
var gulp = require('gulp');
var rtlcss = require('gulp-rtlcss');

gulp.task('default', function () {
	return gulp.src('styles.css')
		.pipe(rtlcss())
		.pipe(gulp.dest('dist'));
});
```
## Configuration

The plugin optionally accepts RTLCSS configuration either as an argument or with a file named `.rtlcssrc` or `.rtlcssrc.json`.

See the [RTLCSS documentation](https://github.com/MohammadYounes/rtlcss) for more information about accepted configuration.

## Example

The below example will result in 2 copies of each stylesheet, one LTR stylesheet and one RTL stylesheet (with "-rtl" appended to the filename before the extension). The example uses autoprefixer, this is just an example of other CSS post-processing being used before rtlcss.

```js
var gulp = require('gulp');
var autoprefixer = require('gulp-autoprefixer');
var rtlcss = require('gulp-rtlcss');
var rename = require('gulp-rename');

gulp.task('styles', function () {
    return gulp.src(['/styles/*.css'])
        .pipe(autoprefixer(["last 2 versions", "> 1%"])) // Other post-processing.
        .pipe(gulp.dest('dist')) // Output LTR stylesheets.
        .pipe(rtlcss()) // Convert to RTL.
        .pipe(rename({ suffix: '-rtl' })) // Append "-rtl" to the filename.
        .pipe(gulp.dest('dist')); // Output RTL stylesheets.
});
```

## Change Log

### 1.0.0 - 2016-02-18

- [#6](https://github.com/jjlharrison/gulp-rtlcss/issues/6) Upgrade to RTLCSS 2.

### 0.1.4 - 2015-01-28

- [#2](https://github.com/jjlharrison/gulp-rtlcss/issues/2) Add support for RTLCSS configuration.

[david-dm-image]: http://img.shields.io/david/jjlharrison/gulp-rtlcss.svg?style=flat
[david-dm-url]: https://david-dm.org/jjlharrison/gulp-rtlcss
[npm-image]: http://img.shields.io/npm/v/gulp-rtlcss.svg?style=flat
[npm-url]: https://www.npmjs.org/package/gulp-rtlcss
[travis-image]: http://img.shields.io/travis/jjlharrison/gulp-rtlcss.svg?style=flat
[travis-url]: https://travis-ci.org/jjlharrison/gulp-rtlcss
[licence-image]: http://img.shields.io/npm/l/gulp-rtlcss.svg?style=flat
[licence-url]: https://tldrlegal.com/license/mit-license
