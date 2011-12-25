var acc = require(process.argv[2]);

var request = require('./request/main.js'); 
request = request.defaults();

var base = 'https://' + process.argv[3] + '.piratenpad.de';
var padId = process.argv[4];

request.get(base, function (error, response, body) {
  if (!error && response.statusCode == 200) {

	request.post({
			url: base + '/ep/account/sign-in'
			, form: {'email': acc.email, 'password' : acc.pw}
		}, 
		function (error, response, body) {
			
			request.get(base + '/' + padId, function (err, response, body) {
				// get the latest version
				var linkToLatestVersion = body.match(/[\w\d\/\-\.]*(latest')/gi);
				linkToLatestVersion = linkToLatestVersion[0].replace(/\'/gi, '');

				getLatest(linkToLatestVersion);

				
			});
			
		}
	);

  }
})

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