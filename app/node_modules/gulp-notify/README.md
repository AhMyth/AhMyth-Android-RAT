# gulp-notify [![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Dependency Status][depstat-image]][depstat-url]

> notification plugin for [gulp](https://github.com/gulpjs/gulp)

## Information
| Package       | gulp-notify  |
| ------------- |--------------|
| Description   | Send messages to Mac Notification Center, Linux notifications (using `notify-send`) or Windows >= 8 (using native toaster) or Growl as fallback, using the [node-notifier](https://github.com/mikaelbr/node-notifier) module. Can also [specify custom notifier](#notifywithreporterfunction). |
| Node Version  | >= 0.8       |

## Table of Contents

<!-- toc -->

* [Information](#information)
* [Requirements](#requirements)
* [Usage](#usage)
* [Notes/tip](#notestip)
* [API](#api)
  * [notify(String)](#notifystring)
  * [notify(Function)](#notifyfunction)
  * [notify(options)](#notifyoptions)
    * [options.onLast](#optionsonlast)
    * [options.emitError](#optionsemiterror)
    * [options.message](#optionsmessage)
    * [options.title](#optionstitle)
    * [options.templateOptions](#optionstemplateoptions)
    * [options.notifier](#optionsnotifier)
  * [notify.withReporter(Function)](#notifywithreporterfunction)
  * [notify.onError()](#notifyonerror)
  * [notify.logLevel(level)](#notifyloglevellevel)
* [Disable `gulp-notify`](#disable-gulp-notify)
* [Examples](#examples)
  * [As jshint reporter](#as-jshint-reporter)
* [License](#license)

<!-- toc stop -->



## Requirements
* **Mac OS X**: No external installation needed (if Mac OS X 10.8 or higher).
* **Linux**: `notify-send`/`notify-osd` should be installed (On Ubuntu this is installed per default)
* **Windows**: Uses native toaster (if Windows 8 or higher).
* **Fallback: Growl**: Growl (for Mac, Windows or similar) should be installed.

See [node-notifier](https://github.com/mikaelbr/node-notifier) for details.

## Usage

First, install `gulp-notify` as a development dependency:

```shell
npm install --save-dev gulp-notify
```

Then, add it to your `gulpfile.js`:

```javascript

var notify = require("gulp-notify");
gulp.src("./src/test.ext")
  .pipe(notify("Hello Gulp!"));
```

Or with template


```javascript

var notify = require("gulp-notify");
gulp.src("./src/test.ext")
  .pipe(notify("Found file: <%= file.relative %>!"));
```

See [examples](examples/gulpfile.js) for more og the API section for various inputs.

## Notes/tip

`gulp-notify` passes on the `vinyl files` even on error. So if you are
using [`gulp-plumber`](https://github.com/floatdrop/gulp-plumber) the run
will not break if the notifier returns an error.

If you want to notify on errors [`gulp-plumber`](https://github.com/floatdrop/gulp-plumber)
can be used to not break the run and force you to have to restart gulp.

You can use [notify.onError()](#notifyonerror) as the errorHandler for gulp-plumber like this:

```javascript
gulp.src("../test/fixtures/*")
      .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
      .pipe(through(function () {
        this.emit("error", new Error("Something happend: Error message!"))
      }));
```

## API

### notify(String)

A message to notify per data on stream.
The string can be a lodash template as
it is passed through [gulp-util.template](https://github.com/gulpjs/gulp-util#templatestring-data).

### notify(Function)
Type: `function(VinylFile)`

Vinyl File from gulp stream passed in as argument.

The result of the function can be a string used as the message or an options object (see below).
If the returned value is a string, it can be a lodash template as
it is passed through [gulp-util.template](https://github.com/gulpjs/gulp-util#templatestring-data).

If `false` is returned from the function the notification won't run.

### notify(options)

*Options are passed onto the reporter, so on Windows, you can define
Growl host, on Mac you can pass in contentImage, and so on.

See [node-notifier](https://github.com/mikaelbr/node-notifier)
for all options*

Default notification values:
 - Gulp logo on regular notification
 - Inverted Gulp logo on error
 - Frog sound on error on Mac.

See also the [advanced example](examples/gulpfile.js).

#### options.onLast
Type: `Boolean`
Default: `false`

If the notification should only happen on the last file
of the stream. Per default a notification is triggered
on each file.

#### options.emitError
Type: `Boolean`
Default: `false`

If the returned stream should emit an error or not.
If `emitError` is true, you have to handle `.on('error')`
manually in case the notifier (gulp-notify) fails. If
the default `false` is set, the error will not be emitted
but simply printed to the console.

This means you can run the notifier on a CI system without
opting it out but simply letting it fail gracefully.


#### options.message
Type: `String`
Default: File path in stream

The message you wish to attach to file. The string can be a
lodash template as it is passed through [gulp-util.template](https://github.com/gulpjs/gulp-util#templatestring-data).

Example: `Created <%= file.relative %>`.

##### as function
Type: `Function(vinylFile)`

See `notify(Function)`.

#### options.title
Type: `String`
Default: "Gulp Notification"

The title of the notification. The string can be a
lodash template as it is passed through [gulp-util.template](https://github.com/gulpjs/gulp-util#templatestring-data).

Example: `Created <%= file.relative %>`.

##### as function
Type: `Function(vinylFile)`

See `notify(Function)`.

#### options.templateOptions
Type: `Object`
Default: {}

Object passed to the `lodash` template, for additional properties passed to the template.

Examples:

```javascript
gulp.src("../test/fixtures/*")
    .pipe(notify({
      message: "Generated file: <%= file.relative %> @ <%= options.date %>",
      templateOptions: {
        date: new Date()
      }
    }))
```

#### options.notifier
Type: `Function(options, callback)`
Default: node-notifier module

Swap out the notifier by passing in an function.
The function expects two arguments: options and callback.

The callback must be called when the notification is finished. Options
will contain both title and message.

*See `notify.withReporter` for syntactic sugar.*


### notify.on(event, function (notificationOptions)) - Events

**If the `wait` option is set to `true`**, the notifier will tigger
events `click` or `timeout`, whether the user clicks the notification or it
times out. You listen to these events on the main notify object, not the
produces stream.

```js
var notify = require('gulp-notify');

notify.on('click', function (options) {
  console.log('I clicked something!', options);
});

notify.on('timeout', function (options) {
  console.log('The notification timed out', options);
});

gulp.task("click", function () {
  return gulp.src("some/glob/**")
    .pipe(notify({ message: 'Click or wait', wait: true }));
});
```

### notify.withReporter(Function)
Type: `Reporter`

Wraps `options.notifier` to return a new notify-function only using
the passed in reporter.

Example:

```javascript
var custom = notify.withReporter(function (options, callback) {
  console.log("Title:", options.title);
  console.log("Message:", options.message);
  callback();
});

gulp.src("../test/fixtures/1.txt")
    .pipe(custom("This is a message."));

```

This will be the same as

```javascript

gulp.src("../test/fixtures/1.txt")
    .pipe(notify({
      message: "This is a message."
      notifier: function (options, callback) {
        console.log("Title:", options.title);
        console.log("Message:", options.message);
        callback();
      }
    }));
```

But much, much prettier.


### notify.onError()

The exact same API as using `notify()`, but where a `vinyl File`
is passed, the error object is passed instead.

Example:

```javascript
gulp.src("../test/fixtures/*")
      .pipe(through(function () {
        this.emit("error", new Error("Something happend: Error message!"))
      }))
      .on("error", notify.onError(function (error) {
        return "Message to the notifier: " + error.message;
      }));
```

Or simply:

```javascript
gulp.src("../test/fixtures/*")
      .pipe(through(function () {
        this.emit("error", new Error("Something happend: Error message!"))
      }))
      .on("error", notify.onError("Error: <%= error.message %>"));
```

```javascript
gulp.src("../test/fixtures/*")
      .pipe(through(function () {
        this.emit("error", new Error("Something happend: Error message!"))
      }))
      .on("error", notify.onError({
        message: "Error: <%= error.message %>",
        title: "Error running something"
      }));
```

The `onError()` end point does support `lodash.template`.

**`onError()` will automatically end the stream for you. Making it easer for watching.**

### notify.logLevel(level)
Type: `Integer`
Default: `2`

Set if logger should be used or not. If log level is set to 0,
no logging will be used. If no new log level is passed, the
current log level is returned.

* `0`: No logging
* `1`: Log on error
* `2`: Log both on error and regular notification.

If logging is set to `> 0`, the title and
message passed to `gulp-notify` will be logged like so:

```sh
➜  gulp-notify git:(master) ✗ gulp --gulpfile examples/gulpfile.js one
[gulp] Using file /Users/example/gulp-notify/examples/gulpfile.js
[gulp] Working directory changed to /Users/example/repos/gulp-notify/examples
[gulp] Running 'one'...
[gulp] Finished 'one' in 4.08 ms
[gulp] gulp-notify: [Gulp notification] /Users/example/gulp-notify/test/fixtures/1.txt
```

## Disable `gulp-notify`

If you are running on a system that handles notifications poorly or you simply
do not wish to use `gulp-notify` but your project does? You can disable `gulp-notify`
by using enviroment variable `DISABLE_NOTIFIER`.

```
export DISABLE_NOTIFIER=true;
```

This will disable all methods; `notify()`, `notify.onError` and `notify.withReporter`.

## Examples

To see all examples run from root:

```shell
$ gulp --gulpfile examples/gulpfile.js --tasks
[gulp] Using file /Users/example/gulp-notify/examples/gulpfile.js
[gulp] Working directory changed to /Users/example/gulp-notify/examples
[gulp] Tasks for /Users/example/gulp-notify/examples/gulpfile.js
[gulp] ├── multiple
[gulp] ├── one
[gulp] ├── message
[gulp] ├── customReporter
[gulp] ├── template
[gulp] ├── templateadv
[gulp] ├── function
[gulp] ├── onlast
[gulp] ├── advanceMac
[gulp] ├── error
[gulp] ├── forceGrowl
[gulp] └── customError
```

To run an example:
```shell
$ gulp --gulpfile examples/gulpfile.js multiple
[gulp] Using file /Users/example/gulp-notify/examples/gulpfile.js
[gulp] Working directory changed to /Users/example/gulp-notify/examples
[gulp] Running 'multiple'...
[gulp] Finished 'multiple' in 3.75 ms
```

### As jshint reporter

`gulp-notify` can easily be used as jshint reporter.
As jshint exposes the result on the vinyl file we can
use them in a function like so:

```javascript
gulp.task('lint', function() {
  gulp.src('/src/**/*.js')
    .pipe(jshint())
    // Use gulp-notify as jshint reporter
    .pipe(notify(function (file) {
      if (file.jshint.success) {
        // Don't show something if success
        return false;
      }

      var errors = file.jshint.results.map(function (data) {
        if (data.error) {
          return "(" + data.error.line + ':' + data.error.character + ') ' + data.error.reason;
        }
      }).join("\n");
      return file.relative + " (" + file.jshint.results.length + " errors)\n" + errors;
    }));
});
```

If you use a function for message in `gulp-notify`, the message won't be shown.
This is true for both direct use of function and `{ message: function () {}}`.

[![NPM downloads][npm-downloads]][npm-url]

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)

[npm-url]: https://npmjs.org/package/gulp-notify
[npm-image]: http://img.shields.io/npm/v/gulp-notify.svg?style=flat
[npm-downloads]: http://img.shields.io/npm/dm/gulp-notify.svg?style=flat

[travis-url]: http://travis-ci.org/mikaelbr/gulp-notify
[travis-image]: http://img.shields.io/travis/mikaelbr/gulp-notify.svg?style=flat

[depstat-url]: https://gemnasium.com/mikaelbr/gulp-notify
[depstat-image]: http://img.shields.io/gemnasium/mikaelbr/gulp-notify.svg?style=flat
