#!/bin/dash 

STATUSFILE=".legit/status.txt"
ADDFOLDER=".legit/adds"
COMMITFOLDER=".legit/commits"
CLOGFILE=".legit/commits/commitLog"

# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-status: error: no .legit directory containing legit repository exists"
    exit 1
fi

# check if there is any commits, if there is, pull the latest commit
if ! [ -f "$CLOGFILE" ]; then
    echo "legit-status: error: your repository does not have any commits yet"
    exit 1
else 
    latestCommit=$(head -n1 "$CLOGFILE" | cut -d' ' -f1)
    commitNumber=$(($latestCommit + 1))
fi

# # argument checking
# if [ "$#" -gt 0 ]; then
#     echo "usage: legit-status"
#     exit 1
# fi

# refresh the statusFile
echo "" > "$STATUSFILE"

latestCommitFolder="$COMMITFOLDER/$latestCommit"
# working directory
for arg in *
do
    # account for empty folder 
    ! [ -f "$arg" ] && continue
    addFile="$ADDFOLDER/$arg"
    commitFile="$latestCommitFolder/$arg"
    if [ -f "$addFile" ]; then
        # if file exsists in both add and commit
        if [ -f "$commitFile" ]; then
            # working == add, working != commit
            if ( cmp -s "$arg" "$addFile" && ! cmp -s "$arg" "$commitFile" ); then
                echo "case 1"
                echo "$arg - file changed, changes staged for commit" >> "$STATUSFILE" && continue
            fi

            # working != add, working == commit
            if ( ! cmp -s "$arg" "$addFile" && cmp -s "$arg" "$commitFile" ); then
                echo "case 2"
                echo "$arg - file changed, different changes staged for commit" >> "$STATUSFILE" && continue
            fi

            # working != add, working != commit, add != commit
            if ( ! cmp -s "$arg" "$addFile" && ! cmp -s "$arg" "$commitFile" && ! cmp -s "$addFile" "$commitFile" ); then
                echo "case 3"
                echo "$arg - file changed, different changes staged for commit" >> "$STATUSFILE" && continue
            fi

            # working != add, working != commit, add == commit
            if ( ! cmp -s "$arg" "$addFile" && ! cmp -s "$arg" "$commitFile" && cmp -s "$addFile" "$commitFile" ); then
                echo "case 4"
                echo "$arg - file changed, changes not staged for commit" >> "$STATUSFILE" && continue
            fi

            # working == add, working == commit, same as repo 
            if ( cmp -s "$arg" "$addFile" && cmp -s "$arg" "$commitFile" ); then
                echo "case 5"
                echo "$arg - same as repo" >> "$STATUSFILE" && continue
            fi
        else
        # file in working directory and add only
            echo "case 6"
            echo "$arg - added to index" >> "$STATUSFILE" && continue 
        fi
    elif [ -f "$commitFile" ]; then
        # file in commits and working directory only
        echo "case 7"
        echo "$arg - untracked" >> "$STATUSFILE" && continue 
    else 
    # file not in add or commit, must be untracked
        echo "case 8"
        echo "$arg - untracked" >> "$STATUSFILE" && continue
    fi
done

# add folder
for arg in "$ADDFOLDER"/*
do
    # account for empty folder
    ! [ -f "$arg" ] && continue
    rootFile=$( basename $arg )
    commitFile="$latestCommitFolder/$rootFile"
    # avoid overlap and only go through if file is not in working directory
    if ! [ -f "$rootFile" ]; then
        if ! [ -f "$commitFile" ]; then
            echo "case 9"
            echo "$rootFile - added to index" >> "$STATUSFILE" && continue
        fi
        # file not in working directory, add == commit
        if ( cmp "$arg" "$commitFile" ); then
            echo "case 10"
            echo "$rootFile - file deleted" >> "$STATUSFILE" && continue
        else
            echo "case 11"
            echo "$rootFile - file deleted, different changes staged for commit" >> "$STATUSFILE" && continue
        fi
    fi
done

for arg in "$latestCommitFolder"/*
do
    # account for empty folder
    ! [ -f "$arg" ] && continue
    rootFile=$( basename $arg )
    addFile="$ADDFOLDER/$rootFile"
    # echo "$addFile"
    if ( ! [ -f "$rootFile" ] && ! [ -f "$addFile" ] ); then
        echo "case 12"
        echo "$rootFile - deleted" >> "$STATUSFILE" && continue
    fi
done

sort "$STATUSFILE" | tail -n +2 | cat