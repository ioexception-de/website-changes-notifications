#!/bin/sh
md5path=`which md5`
nodepath=`which node`

# hash the path to the path of the account config file
tmpfilename=`$md5path -q ${2}`

localcopy="./tmp/$tmpfilename".html
onlinecopy="./tmp/$tmpfilename"_new.html

$nodepath ./notify.js ${2} > $onlinecopy

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