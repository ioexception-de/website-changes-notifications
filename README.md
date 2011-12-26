# Readme

The so called "Piratepads" are a comfortable way to collaborate on documents. 
You can easily set up your own pad via [piratenpad.de](http://piratenpad.de).

We often use the pad for brainstorming and coordinating stuff, but I have lost
track of the different pads.

This script enables an easy way to keep track. It sends a mail once a new change
is discovered. The script should be executed via a cronjob.


# Installation

	git clone https://github.com/cmichi/piratenpad-notifications.git
	cd piratenpad-notifications/
	echo "exports.email = 'user'; 			\
		  exports.pw = 'pw';      			\
		  exports.padDomain = 'subdomain'; 	\
		  exports.padId = 1;" > acc.js
	
	# initialize it
	./check-for-changes.sh john@doe.de ./acc.js
	
Once initialized you should get a mail. If the script is started again 
you will only get mails if something changed. 

It might be a good idea to create a cronjob for the script:

	*/15 * * * * cd ~/piratenpad-notifier/ && ./check-for-changes.sh "john@doe.de" "./pad1.js" 
	*/15 * * * * cd ~/piratenpad-notifier/ && ./check-for-changes.sh "john@doe.de" "./pad2.js" 
	...
	
This way you can easily get notifications for multiple pads.
		

# License

This project only works with the [request](https://github.com/mikeal/request) library 
by mikeal. request is licensed under Apache 2.0. 

This project is licensed under MIT:

	Copyright (c) 2011 Michael Mueller, <http://micha.elmueller.net/>
	
	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.