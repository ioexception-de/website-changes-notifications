#!/bin/sh
node notify.js > tmp_new.html

if ! cmp -s tmp_new.html tmp.html; then
	# files are different
	diff tmp_new.html tmp.html | mail -s "[Piratenpad] Changes" you@mail.com
	echo "sending mail.."
	
	rm tmp.html
	mv tmp_new.html tmp.html
else
	echo "no changes..."
fi