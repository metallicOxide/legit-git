#!/bin/dash

# path
ADDFOLDER=".legit/adds"
CLOGFILE=".legit/commits/commitLog"

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-add: error: no .legit directory containing legit repository exists"
    exit 1
fi

# check if there is any commits, if there is, pull the latest commit
if ! [ -f "$CLOGFILE" ]; then
    echo "legit-rm: error: your repository does not have any commits yet"
    exit 1
else 
    latestCommit=$(head -n1 "$CLOGFILE" | cut -d' ' -f1)
    commitNumber=$(($latestCommit + 1))
fi

# check if number of arguments are valid ie >= 1
if [ "$#" -lt 2 ]; then
    echo "usage: legit-rm [--force] [--cached] <filenames>"
    exit 1
fi

# if [ "$1" = "--force" -o "$2" = "--force" ]; then
#     forceArg=$(( $forceArg + 1 ))
#     argTag=$(( $argTag + 1 ))
# fi


# if [ "$1" = "--cached" -o "$2" = "--cached" ]; then
#     cacheArg=$(( $cacheArg + 1 ))
#     argTag=$(( $argTag + 1 ))
# fi

forceArg=0
cacheArg=0
# argTag=0 
for arg in "$@"
do
    argCheck=$( echo "$arg" | egrep -e '^-')
    if ( [ "$arg" = "$argCheck" ] && [ "$argCheck" != '--cached' -a "$argCheck" != '--force' ] ); then
        # echo "unknown arg"
        echo "usage: legit-rm [--force] [--cached] <filenames>"
        exit 1
    fi

    [ "$arg" = "--force" ] && forceArg=$(( forceArg + 1 )) 
    [ "$arg" = "--cacheArg" ] && cacheArg=$(( cacheArg + 1 ))
done

if [ "$forceArg" -gt 1 -o "$cacheArg" -gt 1 ]; then
    # echo "too many force or cache"
    echo "usage: legit-rm [--force] [--cached] <filenames>"
    exit 1
fi

latestCommit=$( echo "$COMMITFOLDER$latestCommit" )
# check file names and if index has files
for args in "$@"
do
    addFile = $( echo "$ADDFOLDER/$args" )
    check=$(echo "$args" | egrep -E '^[a-zA-Z0-9][a-zA-Z0-9_.\-]*$')
    # check should fail if file have weird names
    if ! [ "$check" = "$args" ] ; then
        echo "legit-rm: error: invalid filename '$args'"
        exit 1
    fi
    
    # error if file is directory
    if [ -d "$args" ]; then
        echo "legit-rm: error: '$args' is not a regular file"
        exit 1
    fi

    # if file does not exsist in repository, then don't add it
    if ! [ -f "$addFile" ]; then
        echo "legit-rm: error: '$args' is not in the legit repository"
        exit 1
    fi

    # if file in add is different to latest commit
    if ( ! [ -f "$latestCommit/$args" ] || ! cmp -s "$addFile" "$latestCommit/$args" ); then
        if ( ! [ -f "$args" ] && [ "$cacheArg" -ne 1 -a  "$forceArg" -ne 1 ] && cmp -s "$args" "$addFile" ); then
            echo "legit-rm: error: '$args' has changes staged in the index"
            exit 1
        elif ( ! cmp -s "$args" "$addFile" ); then
            echo "legit-rm: error: '$args' in index is different to both working file and repository"
            exit 1
        fi
    elif

    elif


    fi
    if ( [ "$cacheArg" -ne 1 -a  "$forceArg" -ne 1 ] )
done
# forceArg=0
# cacheArg=0
# argTag=0 

# if [ "$1" = "--force" -o "$2" = "--cache" ]; then
#     $forceArg=1
#     $argTag=1
# elif [ "$1" = "--cached" -o "$2" = "--cached" ]; then
#     $cacheArg=1
#     $argTag=1
# elif ( [ "$1" = "--cached" -a  ] ||  
# fi

# check argument validity

