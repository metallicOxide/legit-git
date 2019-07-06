#!/bin/dash

ADDFOLDER=".legit/adds"
COMMITFOLDER=".legit/commits/"

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-add: error: no .legit directory containing legit repository exists"
    exit 1
fi

# check for correct number of arguments
if ! [ "$#" -eq 1 ]; then
    echo "usage: legit-show <commit number>:<filename>"
    exit 1
fi

# checks if input argument follows correct format
check=$( echo "$1" | egrep -e '^[0-9]*:[a-zA-Z0-9_.\-]*$' )
if ! [ "$check" = "$1" ]; then
    echo "usage: legit-show <commit number>:<filename>"
    exit 1
fi

commitNum=$( echo "$check" | cut -d':' -f1 )
# echo "$commitNum"
targetFile=$( echo "$check" | cut -d':' -f2 )
# echo "$targetFile"

if ! [ "$commitNum" = "" ]; then
    if [ -f $COMMITFOLDER$commitNum/$targetFile ]; then
        cat $COMMITFOLDER$commitNum/$targetFile
    else
        echo "Error: $COMMITFOLDER$commitNum/$targetFile does not exsist"
        exit 1
    fi
else
    if [ -f $ADDFOLDER/$targetFile ]; then
        cat $ADDFOLDER/$targetFile
    else
        echo "Error: $ADDFOLDER/$targetFile does not exsist"
        exit 1
    fi
fi

