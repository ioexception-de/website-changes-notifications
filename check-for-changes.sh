#!/bin/sh
tmpname=`md5 -q ${2}`
node notify.js ${2} > "$tmpname"_new.html

# temporary local copy already exists?
if [ ! -f "$tmpname".html ]
then
	echo "initializing..."
	cp "$tmpname"_new.html "$tmpname".html
fi

if ! cmp -s "$tmpname"_new.html "$tmpname".html; then
	# files are different
	diff "$tmpname"_new.html "$tmpname".html | mail -s "[Piratenpad] Changes" ${1}
	echo "sending mail.."
	
	rm "$tmpname".html
	mv "$tmpname"_new.html "$tmpname".html
else
	echo "no changes..."
fi