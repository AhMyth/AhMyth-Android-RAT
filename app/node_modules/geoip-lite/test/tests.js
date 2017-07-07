var geoip = require('../lib/geoip');

module.exports = {
	testLookup: function(test) {
		test.expect(2);

		var ip = '8.8.4.4';
		var ipv6 = '2001:4860:b002::68';

		var actual = geoip.lookup(ip);

		test.ok(actual, 'should return data about IPv4.');

		actual = geoip.lookup(ipv6);

		test.ok(actual, 'should return data about IPv6.');

		test.done();
	}, 

	testUTF8: function(test) {
		test.expect(2);

		var ip = "31.17.106.227";
		var expected = "Neumünster";
		var actual = geoip.lookup(ip);

		test.ok(actual, "Should return a non-null value for " + ip);
		test.equal(actual.city, expected, "UTF8 city name does not match");
		
		test.done();
	},

	testMetro: function(test) {
		test.expect(2);

		var actual = geoip.lookup("23.240.63.68");

		test.equal(actual.city, "Santa Ana");
		test.equal(actual.metro, 803);

		test.done();
	},

	testIPv4MappedIPv6: function (test) {
		test.expect(2);

		var actual = geoip.lookup("::ffff:173.185.182.82");

		test.equal(actual.city, "Glen Rose");
		test.equal(actual.metro, 623);

		test.done();
	}
};
