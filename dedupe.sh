#!/bin/sh

BASEDIR="."
HASHFILE="/tmp/hashfile$$"

find $BASEDIR -type f -exec md5 \{\} \; > $HASHFILE

for HASH in `cut -d= -f2 $HASHFILE | sort | uniq -c | tr -s ' ' | egrep -v "^ 1 " | cut -d' ' -f3`; do
    #echo "Duplicate hash $HASH found"
    grep $HASH $HASHFILE | tail -n 1 | xargs | sed 's/MD5 (//;s/)[^)]*$//' 
	#colrm 1 5 | cut -d') = ' -f1
done

rm -f $HASHFILE
