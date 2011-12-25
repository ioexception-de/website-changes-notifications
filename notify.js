var acc = require('./acc.js');

var request = require('./request/main.js'); 
request = request.defaults();


request.get('https://ulm-chaos-macht-schule.piratenpad.de', function (error, response, body) {
  if (!error && response.statusCode == 200) {

	request.post({
			url: 'https://ulm-chaos-macht-schule.piratenpad.de/ep/account/sign-in?cont=https%3a%2f%2fulm-chaos-macht-schule.piratenpad.de%2f'
			, form: {'email': acc.email, 'password' : acc.pw}
		}, 
		function (error, response, body) {
			
			request.get('https://ulm-chaos-macht-schule.piratenpad.de/1', function (err, response, body) {
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
		request.get('https://ulm-chaos-macht-schule.piratenpad.de' + linkToLatestVersion, function (err, response, body) {
		var start = body.search('id="padcontent">') + 'id="padcontent">'.length;
		var end = body.search("<!-- /padeditor -->");
		var padContent = body.substring(start, end);
		
		// strip all html tags 
		padContent = padContent.replace(/(<[^>]+>)|(&nbsp;)/gi, '');
		
		console.log(padContent.trim());
	});
	
}