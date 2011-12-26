#!/bin/sh
tmpname=`/sbin/md5 -q ${2}`
/usr/local/bin/node ./notify.js ${2} > "$tmpname"_new.html

# temporary local copy already exists?
if [ ! -f "$tmpname".html ]
then
	echo "initializing..."
	cp "$tmpname"_new.html "$tmpname".html
fi

if ! cmp -s "$tmpname"_new.html "$tmpname".html; then
	# files are different
	diff "$tmpname"_new.html "$tmpname".html | mail -s "[Piratenpad] Changes ${2}" ${1}
	echo "sending mail.."
	
	rm "$tmpname".html
	mv "$tmpname"_new.html "$tmpname".html
else
	echo "no changes..."
fi