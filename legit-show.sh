#!/bin/dash

ADDFOLDER=".legit/adds"
COMMITFOLDER=".legit/commits/"
CLOGFILE=".legit/commits/commitLog"

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-show: error: no .legit directory containing legit repository exists" >&2
    exit 1
fi

# check if there is any commits, if there is, pull the latest commit
if ! [ -f "$CLOGFILE" ]; then
    echo "legit-show: error: your repository does not have any commits yet" >&2
    exit 1
fi

# check for correct number of arguments
if ! [ "$#" -eq 1 ]; then
    echo "usage: legit-show <commit>:<filename>" >&2
    exit 1
fi

# checks if input argument follows correct format
checkCol=$( echo "$1" | egrep -e ':' )
if ! [ "$checkCol" = "$1" ]; then
    echo "legit-show: error: invalid object $1" >&2
    exit 1
fi

commitNum=$( echo "$checkCol" | cut -d':' -f1 )
targetFile=$( echo "$checkCol" | cut -d':' -f2 )

if ! [ "$commitNum" = "" ]; then
    if [ -f "$COMMITFOLDER$commitNum/$targetFile" ]; then
        cat "$COMMITFOLDER$commitNum/$targetFile"
    else
        if ! [ -d "$COMMITFOLDER$commitNum" ]; then
            echo "legit-show: error: unknown commit '$commitNum'" >&2
            exit 1
        fi
        echo "legit-show: error: '$targetFile' not found in commit $commitNum" >&2
        exit 1
    fi
else
    if [ -f "$ADDFOLDER/$targetFile" ]; then
        cat "$ADDFOLDER/$targetFile"
    else
        echo "legit-show: error: '$targetFile' not found in index" >&2
        exit 1
    fi
fi


