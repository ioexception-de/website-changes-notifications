#!/bin/sh
# to execute this script:
# 	./check-for-changes.sh john@doe.de ./config.js
#

nodepath=`which node`

# the bash of the configuration-file in ${2} is used 
# as a name for temporary files
if [ "$(uname)" = "Linux" ]; 
then
	md5path=`which md5sum`
	tmpfilename=`echo ${2} | $md5path | cut -f1 -d' '`
else
	# only tested on Darwin, should work on other *BSDs too
	md5path=`which md5`
	tmpfilename=`$md5path -q ${2}`
fi

localcopy="./tmp/$tmpfilename".html
onlinecopy="./tmp/$tmpfilename"_new.html

$nodepath ./notify.js ${2} > $onlinecopy

# temporary local copy already exists?
if [ ! -f $localcopy ]
then
	echo "initializing..."
	cp $onlinecopy $localcopy
fi

# are the files different?
if ! cmp -s $onlinecopy $localcopy; 
then
	echo "sending mail.."
	diff $onlinecopy $localcopy | mail -s "[Piratenpad] Changes ${2}" ${1}
	
	rm $localcopy
	mv $onlinecopy $localcopy
else
	echo "no changes..."
fi