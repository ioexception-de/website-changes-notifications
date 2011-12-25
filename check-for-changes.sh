#!/bin/sh
node notify.js ${2} ${3} ${4} > tmp_new.html

if ! cmp -s tmp_new.html tmp.html; then
	# files are different
	diff tmp_new.html tmp.html | mail -s "[Piratenpad] Changes" ${1}
	echo "sending mail.."
	
	rm tmp.html
	mv tmp_new.html tmp.html
else
	echo "no changes..."
fi