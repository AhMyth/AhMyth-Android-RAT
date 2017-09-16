var through = require("through2");
var gutil = require("gulp-util");
var notifier = require("node-notifier");
var report = require("./report");

"use strict";

// Default log level
var logLevel = 2;

// Default logger
var fnLog = gutil.log;

var logError = module.exports.logError = function (options, isError) {
  if (!logLevel) return;
  if (logLevel === 1 && !isError) return;

  color = isError ? "red" : "green";
  if (!gutil.colors[color]) return;
  fnLog(gutil.colors.cyan('gulp-notify') + ':',
           '[' + gutil.colors.blue(options.title) + ']',
            gutil.colors[color].call(gutil.colors, options.message)
           );
};


// Expose onError behaviour
module.exports.onError = function (options, callback) {
  var reporter;
  options = options || {};
  var templateOptions = options.templateOptions || {};
  var callback = callback || function (err) {
    err && logError({
      title: "Error running notifier",
      message: "Could not send message: " + err.message
    }, true);
  };

  if (options.notifier) {
    reporter = options.notifier;
  } else {
    reporter = notifier.notify.bind(notifier);
  }
  return function (error) {
    var self = this;
    report(reporter, error, options, templateOptions, function () {
      callback.apply(self, arguments);
      self.emit && self.emit('end');
    });
  };
};

// Expose to set log level
module.exports.logLevel = function (newLogLevel) {
  if (newLogLevel === void 0) return logLevel;
  logLevel = newLogLevel;
};

// Expose to set new logger
module.exports.logger = function (newLogger) {
  if (!newLogger) return fnLog;
  fnLog = newLogger;
};
