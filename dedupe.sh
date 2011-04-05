#!/bin/sh

if [$# gt 1]; then
	BASEDIR="."
else
	BASEDIR=$1
	echo "Scanning directory $BASEDIR"
fi

HASHFILE="/tmp/hashfile$$"

find $BASEDIR -type f -print0 | xargs -0 md5 > $HASHFILE

for HASH in `cut -d= -f2 $HASHFILE | sort | uniq -c | tr -s ' ' | egrep -v "^ 1 " | cut -d' ' -f3`; do
    #echo "Duplicate hash $HASH found"
    grep $HASH $HASHFILE | tail -n 1 | xargs | awk '{print substr($0,6,length($0)-41)}'
	#sed 's/MD5 (//;s/)[^)]*$//' 
done

rm -f $HASHFILE
