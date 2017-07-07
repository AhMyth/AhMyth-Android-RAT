var api = require('./lib/extra_api');
var through = require('through2');

"use strict";

var disable = !!process.env.DISABLE_NOTIFIER;

var fn = function (i) { return function () { return i; }; };
var noopError = fn(function (err) {});
var noopStream = function () { return through.obj(); };

// Expose plugin
module.exports = disable ? noopStream : require('./lib/notify');

// Expose onError behaviour
module.exports.onError = disable ? noopError : api.onError;

// Disable all logging
disable && api.logLevel(0);

// Expose to set log level
module.exports.logLevel = api.logLevel;

// Expose to set new logger
module.exports.logger = api.logger;

// Syntactiv sugar
module.exports.withReporter = disable ? fn(noopStream) : require('./lib/withReporter');
