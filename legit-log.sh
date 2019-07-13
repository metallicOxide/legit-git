#!/bin/dash

CLOGFILE=".legit/commits/commitLog"

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-log: error: no .legit directory containing legit repository exists" >&2
    exit 1
fi

if ! [ -f "$CLOGFILE" ]; then
    echo "legit-log: error: your repository does not have any commits yet" >&2
    exit 1
fi

if [ "$#" -gt 0 ]; then
    echo "usage: legit-log" >&2
    exit 1
fi

cat $CLOGFILE