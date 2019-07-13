#!/bin/dash

# path
ADDFOLDER=".legit/adds"
CLOGFILE=".legit/commits/commitLog"

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-add: error: no .legit directory containing legit repository exists" >&2
    exit 1
fi

# check if number of arguments are valid ie >= 1
if [ "$#" -lt 1 ]; then
    echo "usage: legit-add <filenames>" >&2
fi

# check if arguments are valid files
for args in "$@"
do
    check=$(echo "$args" | egrep -E '^[a-zA-Z0-9][a-zA-Z0-9_.\-]*$')
    # check should fail if they are directory or have weird names
    if ! [ "$check" = "$args" ]; then
        echo "legit-add: error: invalid filename '$args'" >&2
        exit 1
    fi

    if [ -d "$args" ]; then
        echo "legit-add: error: '$args' is not a regular file" >&2
        exit 1
    fi

    # if argument does not exsist in working directory and does not also 
    # exsist in staging folder, then chuck error
    if ( ! [ -f "$args" ] && ! [ -f "$ADDFOLDER/$args" ] ); then
        echo "legit-add: error: can not open '$args'" >&2
        exit 1
    fi
done

# copies files to .legit to initalize staging
for args in "$@"
do
    # if file given as argument does not exsist in working directory and staging folder then
    # update status of file in staging by removing file from staging folder 
    if ! [ -f "$args" ]; then
        rm .legit/adds/"$args"
        continue
    fi
    # copy file to staging folder
    cp "$args" "$ADDFOLDER"
done