var url = process.argv[2];
var request = require('../lib/request/main.js'); 

(function getLatestHTML() {
	request.get(url, function (err, resp, body) {				
		if (!err && resp.statusCode == 200) {
			console.log(body.trim());
		}
	});
})();
