#!/bin/dash

counter=0

if [ "$#" -gt 0 ]; then
    echo "usage: legit-init"
    exit 1
fi

if [ -d .legit ]; then
    echo "$0: error: .legit already exists"
    exit 1
fi

mkdir .legit
mkdir .legit/adds
mkdir .legit/commits
echo "Initialized empty legit repository in .legit"
