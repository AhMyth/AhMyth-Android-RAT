"use strict";

var through = require('through2');
var report = require('./report');
var extra = require('./extra_api');
var notifier = require('node-notifier');

module.exports = function (options) {
  var reporter;
  var lastFile = null;

  options = options || {};
  var templateOptions = options.templateOptions || {};

  if (options.notifier) {
    reporter = options.notifier;
  } else {
    if (options.host || options.appName || options.port) {
      notifier = new notifier.Notification({
        host: options.host,
        appName: options.appName,
        port: options.port
      });
    }
    reporter = notifier.notify.bind(notifier);
  }

  function notify (file, enc, callback) {
    var stream = this;

    report(reporter, file, options, templateOptions, function (err) {
      logError(err, stream);

      if (options.emitError) {
        stream.push(file);
        return callback();
      }
    });

    if (!options.emitError) {
      stream.push(file);
      return callback();
    }
  }

  if (!options.onLast) {
    return through.obj(notify);
  }

  // Only send notification on the last file.
  return through.obj(function (file, enc, callback) {
    lastFile = file;
    this.push(file);
    callback();
  }, function (callback) {
    var stream = this;

    if (!lastFile) {
      return callback();
    }

    report(reporter, lastFile, options, templateOptions, function (err) {
      logError(err, stream);
      if (options.emitError) {
        return callback();
      }
    });

    lastFile = null; // reset
    if (!options.emitError) {
      return callback();
    }
  });

  function logError (err, stream) {
    if (!err) return;

    var isGrowl = notifier && notifier instanceof notifier.Growl;
    var isEcon = err.message.indexOf('ECONNREFUSED') !== -1;
    var dropMessage = isGrowl && isEcon;

    if (dropMessage) {
      return extra.logError({
        title: 'Info',
        message: 'No notification system installed.'
      });
    }

    if (options.emitError) return stream.emit('error', err);

    extra.logError({
      title: 'Error in notifier',
      message: err
    }, true);
  }
};

module.exports.on = function (event, fn) {
  if (!notifier) return;
  return notifier.on(event, function (notifyObject, options) {
    return fn(options);
  });
};
