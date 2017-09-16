Changelog
===

#### `v2.2.0`
1. Adds support for changing host, port and appName for Growl.
2. Adds support for templating on subtitle and open (for Notification Center).
3. Adds support for returning options in function argument style.

#### `v2.1.0`
1. Adds `click` and `timeout` events to `notify` object.

#### `v2.0.1`
1. Now `onError()` calls `.emit('end')` for you on the stream. Making watching and usage easier.

#### `v2.0.0`
1. Major bump due to node-notifier (underlying module for doing notifications) have changed it's API and thus this has as well.
See [changelog on node-notifier](https://github.com/mikaelbr/node-notifier/blob/master/CHANGELOG.md#v400).

#### `v1.8.0`
1. Changes notification to continue stream at once (unless when using the stream - i.e. when emitting errors)
2. Fixes example gulpfile by returning stream for each task.


#### `v1.7.1`
1. Fixes issue with Windows 7 and Growl/Bubble conditional.

#### `v1.7.0`
1. Now supports native windows 7 and earlier notifications, through balloons! This means that gulp-notify can be used on any platform without any extra installs.

#### `v1.6.0`
1. Now supports native windows notifications!

#### `v1.5.1`
1. Changes success icon [ref #48](https://github.com/mikaelbr/gulp-notify/issues/48).
2. Changes to show better info notice if no notifier is found [ref #48](https://github.com/mikaelbr/gulp-notify/issues/49).
3. Adds ToC to the README.md.

#### `v1.5.0`
1. Adds a global way to disable notifier by doing `export DISABLE_NOTIFIER=true`.

#### `v1.4.0`
1. Adds default icons for regular notification and error. Also adds Frog sound on error on Mac.

#### `v1.3.1`
1. Updates node-notifier dependency. Adds support for app icon and images for Mac.

#### `v1.3.0`
1. Adds default setting for failing silently. Introduces concept emitError flag to still emit errors

#### `v1.2.1`
1. The entire options-object is passed to the notifier, allowing pass additional information to notifiers.
2. Adds support for showing errors returned from the notifiers and showing these errors in the console.

#### `v1.1.0`
1. Bumps dependency for `node-notifier`. Now supports Growl on Windows!

#### `v1.0.0-beta`
1. Major rewrites and restructure in code
2. Lock down on API, changes `setLogLevel` to `logLevel`
3. Exposes logLevel and logger on the withReporter object.

#### `v0.6.2`
1. Adds another logging level: 0 - none, 1 - error, 2 - all.

#### `v0.6.1`
1. Added `.onError` method on object created by `withReporter`
2. Added colored logging on success / error

#### `v0.5.0`
1. Added API end point `notify.withReporter(Reporter)` as syntactic suger for custom reporter
2. Updated dependency for node-notfier - now checking if `notify-send` is installed on the Linux box
