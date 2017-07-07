var gutil = require("gulp-util");
var api = require("./extra_api");
var notify = require("./notify");

module.exports = function (reporter) {
  if (!reporter) throw new gutil.PluginError("gulp-notify", "No custom reporter defined.");

  var inner = function (options) {
    options = setOptions(options, reporter);
    return notify(options);
  };

  inner.onError = function (options) {
    options = setOptions(options, reporter);
    return api.onError(options);
  };

  inner.logLevel = api.logLevel;
  inner.logger = api.logger;

  return inner;
};

function setOptions (options, reporter) {
  options = options || {};

  if (typeof options !== "object") {
    options = {
      message: options
    };
  }

  options.notifier = reporter;
  return options;
}
