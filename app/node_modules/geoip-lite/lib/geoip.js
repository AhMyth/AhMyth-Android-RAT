var fs = require('fs');
var net = require('net');
var path = require('path');

fs.existsSync = fs.existsSync || path.existsSync;

var utils = require('./utils');
var fsWatcher = require('./fsWatcher');
var async = require('async');

var watcherName = 'dataWatcher';


var geodatadir;

if (typeof global.geodatadir === 'undefined'){
	geodatadir = path.join(__dirname, '/../data/');
} else {
	geodatadir = global.geodatadir;
}

var dataFiles = {
	city: path.join(geodatadir, 'geoip-city.dat'),
	city6: path.join(geodatadir, 'geoip-city6.dat'),
	cityNames: path.join(geodatadir, 'geoip-city-names.dat'),
	country: path.join(geodatadir, 'geoip-country.dat'),
	country6: path.join(geodatadir, 'geoip-country6.dat')
};

var privateRange4 = [
		[utils.aton4('10.0.0.0'), utils.aton4('10.255.255.255')],
		[utils.aton4('172.16.0.0'), utils.aton4('172.31.255.255')],
		[utils.aton4('192.168.0.0'), utils.aton4('192.168.255.255')]
	]

var cache4 = {
	firstIP: null,
	lastIP: null,
	lastLine: 0,
	locationBuffer: null,
	locationRecordSize: 64,
	mainBuffer: null,
	recordSize: 12
};

var cache6 = {
	firstIP: null,
	lastIP: null,
	lastLine: 0,
	mainBuffer: null,
	recordSize: 58
};

var RECORD_SIZE = 10;
var RECORD_SIZE6 = 34

function lookup4(ip) {
	var fline = 0;
	var floor = cache4.lastIP;
	var cline = cache4.lastLine;
	var ceil = cache4.firstIP;
	var line;
	var locId;

	var buffer = cache4.mainBuffer;
	var locBuffer = cache4.locationBuffer;
	var privateRange = privateRange4;
	var recordSize = cache4.recordSize;
	var locRecordSize = cache4.locationRecordSize;

	var i;

	var geodata = {
		range: '',
		country: '',
		region: '',
		city: '',
		ll: [0, 0]
	};

	// outside IPv4 range
	if (ip > cache4.lastIP || ip < cache4.firstIP) {
		return null;
	}

	// private IP
	for (i = 0; i < privateRange.length; i++) {
		if (ip >= privateRange[i][0] && ip <= privateRange[i][1]) {
			return null;
		}
	}

	do {
		line = Math.round((cline - fline) / 2) + fline;
		floor = buffer.readUInt32BE(line * recordSize);
		ceil  = buffer.readUInt32BE((line * recordSize) + 4);

		if (floor <= ip && ceil >= ip) {
			geodata.range = [floor, ceil];

			if (recordSize === RECORD_SIZE) {
				geodata.country = buffer.toString('utf8', (line * recordSize) + 8, (line * recordSize) + 10);
			} else {
				locId = buffer.readUInt32BE((line * recordSize) + 8) - 1;

				geodata.country = locBuffer.toString('utf8', (locId * locRecordSize) + 0, (locId * locRecordSize) + 2).replace(/\u0000.*/, '');
				geodata.region = locBuffer.toString('utf8', (locId * locRecordSize) + 2, (locId * locRecordSize) + 4).replace(/\u0000.*/, '');
				geodata.ll = [locBuffer.readInt32BE((locId * locRecordSize) + 4) / 10000, locBuffer.readInt32BE((locId * locRecordSize) + 8) / 10000];
				geodata.metro = locBuffer.readInt32BE((locId * locRecordSize) + 12);
				geodata.city = locBuffer.toString('utf8', (locId * locRecordSize) + 16, (locId * locRecordSize) + locRecordSize).replace(/\u0000.*/, '');
			}

			return geodata;
		} else if (fline === cline) {
			return null;
		} else if (fline === (cline - 1)) {
			if (line === fline) {
				fline = cline;
			} else {
				cline = fline;
			}
		} else if (floor > ip) {
			cline = line;
		} else if (ceil < ip) {
			fline = line;
		}
	} while(1);
}

function lookup6(ip) {
	var buffer = cache6.mainBuffer;
	var recordSize = cache6.recordSize;

	var geodata = {
		range: '',
		country: '',
		region: '',
		city: '',
		ll: [0, 0]
	};

	// XXX We only use the first 8 bytes of an IPv6 address
	// This identifies the network, but not the host within
	// the network.  Unless at some point of time we have a
	// global peace treaty and single subnets span multiple
	// countries, this should not be a problem.
	function readip(line, offset) {
		var ii = 0;
		var ip = [];

		for (ii = 0; ii < 2; ii++) {
			ip.push(buffer.readUInt32BE((line * recordSize) + (offset * 16) + (ii * 4)));
		}

		return ip;
	}

	cache6.lastIP = readip(cache6.lastLine, 1);
	cache6.firstIP = readip(0, 0);

	var fline = 0;
	var floor = cache6.lastIP;
	var cline = cache6.lastLine;
	var ceil = cache6.firstIP;
	var line;

	if (utils.cmp6(ip, cache6.lastIP) > 0 || utils.cmp6(ip, cache6.firstIP) < 0) {
		return null;
	}

	do {
		line = Math.round((cline - fline) / 2) + fline;
		floor = readip(line, 0);
		ceil  = readip(line, 1);

		if (utils.cmp6(floor, ip) <= 0 && utils.cmp6(ceil, ip) >= 0) {
			if (recordSize === RECORD_SIZE6) {
				geodata.country = buffer.toString('utf8', (line * recordSize) + 32, (line * recordSize) + 34).replace(/\u0000.*/, '');
			} else {
				geodata.range = [floor, ceil];
				geodata.country = buffer.toString('utf8', (line * recordSize) + 32, (line * recordSize) + 34).replace(/\u0000.*/, '');
				geodata.region = buffer.toString('utf8', (line * recordSize) + 34, (line * recordSize) + 36).replace(/\u0000.*/, '');
				geodata.ll = [buffer.readInt32BE((line * recordSize) + 36) / 10000, buffer.readInt32BE((line * recordSize) + 40) / 10000];
				geodata.city = buffer.toString('utf8', (line * recordSize) + 44, (line * recordSize) + recordSize).replace(/\u0000.*/, '');
			}

			// We do not currently have detailed region/city info for IPv6, but finally have coords
			return geodata;
		} else if (fline === cline) {
			return null;
		} else if (fline === (cline - 1)) {
			if (line === fline) {
				fline = cline;
			} else {
				cline = fline;
			}
		} else if (utils.cmp6(floor, ip) > 0) {
			cline = line;
		} else if (utils.cmp6(ceil, ip) < 0) {
			fline = line;
		}
	} while(1);
}

function get4mapped(ip) {
    var ipv6 = ip.toUpperCase();
    var v6prefixes = ['0:0:0:0:0:FFFF:', '::FFFF:'];
    for (var i = 0; i < v6prefixes.length; i++) {
        var v6prefix = v6prefixes[i];
        if (ipv6.indexOf(v6prefix) == 0) {
            return ipv6.substring(v6prefix.length);
        }
    }
    return null;
}

function preload(callback) {
	var datFile;
	var datSize;
	var asyncCache = {
		firstIP: null,
		lastIP: null,
		lastLine: 0,
		locationBuffer: null,
		locationRecordSize: 64,
		mainBuffer: null,
		recordSize: 12
	};

	//when the preload function receives a callback, do the task asynchronously
	if (typeof arguments[0] === 'function') {
		async.series([
			function (cb) {
				async.series([
					function (cb2) {
						fs.open(dataFiles.cityNames, 'r', function (err, file) {
							datFile = file;
							cb2(err);
						});
					},
					function (cb2) {
						fs.fstat(datFile, function (err, stats) {
							datSize = stats.size;
							asyncCache.locationBuffer = new Buffer(datSize);
							cb2(err);
						});
					},
					function (cb2) {
						fs.read(datFile, asyncCache.locationBuffer, 0, datSize, 0, cb2);
					},
					function (cb2) {
						fs.close(datFile, cb2);
					},
					function (cb2) {
						fs.open(dataFiles.city, 'r', function (err, file) {
							datFile = file;
							cb2(err);
						});
					},
					function (cb2) {
						fs.fstat(datFile, function (err, stats) {
							datSize = stats.size;
							cb2(err);
						});
					}
				], function (err) {
					if (err) {
						if (err.code !== 'ENOENT' && err.code !== 'EBADF') {
							throw err;
						}

						fs.open(dataFiles.country, 'r', function (err, file) {
							if (err) {
								cb(err);
							} else {
								datFile = file;
								fs.fstat(datFile, function (err, stats) {
									datSize = stats.size;
									asyncCache.recordSize = RECORD_SIZE;

									cb();
								});
							}
						});
						
					} else {
						cb();
					}
				});
			},
			function () {
				asyncCache.mainBuffer = new Buffer(datSize);
				
				async.series([
					function (cb2) {
						fs.read(datFile, asyncCache.mainBuffer, 0, datSize, 0, cb2);
					},
					function (cb2) {
						fs.close(datFile, cb2);
					}
				], function (err) {
					if (err) {
						//keep old cache
					} else {
						asyncCache.lastLine = (datSize / asyncCache.recordSize) - 1;
						asyncCache.lastIP = asyncCache.mainBuffer.readUInt32BE((asyncCache.lastLine * asyncCache.recordSize) + 4);
						cache4 = asyncCache;
					}
					callback(err);
				});
			}
		]);
	} else {
		try {
			datFile = fs.openSync(dataFiles.cityNames, 'r');
			datSize = fs.fstatSync(datFile).size;

			if (datSize === 0) {
				throw {
					code: 'EMPTY_FILE'
				};
			}

			cache4.locationBuffer = new Buffer(datSize);
			fs.readSync(datFile, cache4.locationBuffer, 0, datSize, 0);
			fs.closeSync(datFile);

			datFile = fs.openSync(dataFiles.city, 'r');
			datSize = fs.fstatSync(datFile).size;
		} catch(err) {
			if (err.code !== 'ENOENT' && err.code !== 'EBADF' && err.code !== 'EMPTY_FILE') {
				throw err;
			}

			datFile = fs.openSync(dataFiles.country, 'r');
			datSize = fs.fstatSync(datFile).size;
			cache4.recordSize = RECORD_SIZE;
		}

		cache4.mainBuffer = new Buffer(datSize);
		fs.readSync(datFile, cache4.mainBuffer, 0, datSize, 0);

		fs.closeSync(datFile);

		cache4.lastLine = (datSize / cache4.recordSize) - 1;
		cache4.lastIP = cache4.mainBuffer.readUInt32BE((cache4.lastLine * cache4.recordSize) + 4);
		cache4.firstIP = cache4.mainBuffer.readUInt32BE(0);
	}
}

function preload6(callback) {
	var datFile;
	var datSize;
	var asyncCache6 = {
		firstIP: null,
		lastIP: null,
		lastLine: 0,
		mainBuffer: null,
		recordSize: 58
	};

	//when the preload function receives a callback, do the task asynchronously
	if (typeof arguments[0] === 'function') {
		async.series([
			function (cb) {
				async.series([
					function (cb2) {
						fs.open(dataFiles.city6, 'r', function (err, file) {
							datFile = file;
							cb2(err);
						});
					},
					function (cb2) {
						fs.fstat(datFile, function (err, stats) {
							datSize = stats.size;
							cb2(err);
						});
					}
				], function (err) {
					if (err) {
						if (err.code !== 'ENOENT' && err.code !== 'EBADF') {
							throw err;
						}

						fs.open(dataFiles.country6, 'r', function (err, file) {
							if (err) {
								cb(err);
							} else {
								datFile = file;
								fs.fstat(datFile, function (err, stats) {
									datSize = stats.size;
									asyncCache6.recordSize = RECORD_SIZE6;

									cb();
								});
							}
						});
					} else {
						cb();
					}
				});
			},
			function () {
				asyncCache6.mainBuffer = new Buffer(datSize);
				
				async.series([
					function (cb2) {
						fs.read(datFile, asyncCache6.mainBuffer, 0, datSize, 0, cb2);
					},
					function (cb2) {
						fs.close(datFile, cb2);
					}
				], function (err) {
					if (err) {
						//keep old cache
					} else {
						asyncCache6.lastLine = (datSize / asyncCache6.recordSize) - 1;
						cache6 = asyncCache6;
					}
					callback(err);
				});
			}
		]);
	} else {
		try {
			datFile = fs.openSync(dataFiles.city6, 'r');
			datSize = fs.fstatSync(datFile).size;

			if (datSize === 0) {
				throw {
					code: 'EMPTY_FILE'
				};
			}
		} catch(err) {
			if (err.code !== 'ENOENT' && err.code !== 'EBADF' && err.code !== 'EMPTY_FILE') {
				throw err;
			}

			datFile = fs.openSync(dataFiles.country6, 'r');
			datSize = fs.fstatSync(datFile).size;
			cache6.recordSize = RECORD_SIZE6;
		}

		cache6.mainBuffer = new Buffer(datSize);
		fs.readSync(datFile, cache6.mainBuffer, 0, datSize, 0);

		fs.closeSync(datFile);

		cache6.lastLine = (datSize / cache6.recordSize) - 1;
	}
}

module.exports = {
	cmp: utils.cmp,

	lookup: function(ip) {
		if (!ip) {
			return null;
		} else if (typeof ip === 'number') {
			return lookup4(ip);
		} else if (net.isIP(ip) === 4) {
			return lookup4(utils.aton4(ip));
		} else if (net.isIP(ip) === 6) {
			var ipv4 = get4mapped(ip);
			if (ipv4) {
				return lookup4(utils.aton4(ipv4));
			} else {
				return lookup6(utils.aton6(ip));
			}
		}

		return null;
	},

	pretty: function(n) {
		if (typeof n === 'string') {
			return n;
		} else if (typeof n === 'number') {
			return utils.ntoa4(n);
		} else if (n instanceof Array) {
			return utils.ntoa6(n);
		}

		return n;
	},

	// Start watching for data updates. The watcher waits one minute for file transfer to 
	// completete before triggering the callback.
	startWatchingDataUpdate: function (callback) {
		fsWatcher.makeFsWatchFilter(watcherName, geodatadir, 60*1000, function () {
			//Reload data
			async.series([
				function (cb) {
					preload(cb);
				},
				function (cb) {
					preload6(cb);
				}
			], callback);
		});
	},

	// Stop watching for data updates.
	stopWatchingDataUpdate: function () {
		fsWatcher.stopWatching(watcherName);
	}
};

preload();
preload6();

//lookup4 = gen_lookup('geoip-country.dat', 4);
//lookup6 = gen_lookup('geoip-country6.dat', 16);
