#!/bin/dash

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-log: error: no .legit directory containing legit repository exists"
    exit 1
fi

if [ "$#" -gt 0 ]; then
    echo "usage: legit-log"
    exit 1
fi

cat .legit/commits/commitLog