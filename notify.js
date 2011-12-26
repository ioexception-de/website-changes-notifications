var acc = require(process.argv[2]);
var request = require('./request/main.js'); 
//request = request.defaults();

var base = 'https://' + acc.padDomain + '.piratenpad.de';


(function initiateSession() {
	request.get(base, function (error, response, body) {
		if (!error && response.statusCode == 200) {
			login();
		}
	});
})();

function login() {
	var options = {
			url: base + '/ep/account/sign-in', 
			form: {'email': acc.email, 'password' : acc.pw}
	};
	
	request.post(options, function (err, res, body) {	
			request.get(base + '/' + acc.padId, function (err, res, body) {
				// get the latest version of the pad content
				var linkToLatestVersion = body.match(/[\w\d\/\-\.]*(latest')/gi);
				linkToLatestVersion = linkToLatestVersion[0].replace("'", '');

				getLatest(linkToLatestVersion);
			});			
		}
	);	
}

function getLatest(linkToLatestVersion) {
	request.get(base + linkToLatestVersion, function (err, response, body) {
		var start = body.search('id="padcontent">') + 'id="padcontent">'.length;
		var end = body.search("<!-- /padeditor -->");
		var padContent = body.substring(start, end);
		
		// strip all html tags 
		padContent = padContent.replace(/(<[^>]+>)|(&nbsp;)/gi, '');
		
		console.log(padContent.trim());
	});
}
