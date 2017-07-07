'use strict';

module.exports = Entry;

var PassThrough = require('readable-stream/passthrough');
var inherits = require('util').inherits;

inherits(Entry, PassThrough);

function Entry () {
  PassThrough.call(this);
  this.props = {};
}

Entry.prototype.autodrain = function () {
  this.on('readable', this.read.bind(this));
};
