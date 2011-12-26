#!/bin/sh
# hash the path to the path of the account config file
tmpfilename=`/sbin/md5 -q ${2}`
localcopy="./tmp/$tmpfilename".html
onlinecopy="./tmp/$tmpfilename"_new.html

/usr/local/bin/node ./notify.js ${2} > $onlinecopy

# temporary local copy already exists?
if [ ! -f $localcopy ]
then
	echo "initializing..."
	cp $onlinecopy $localcopy
fi

if ! cmp -s $onlinecopy $localcopy; then
	# files are different
	diff $onlinecopy $localcopy | mail -s "[Piratenpad] Changes ${2}" ${1}
	echo "sending mail.."
	
	rm $localcopy
	mv $onlinecopy $localcopy
else
	echo "no changes..."
fi