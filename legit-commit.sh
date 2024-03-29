#!/bin/dash

# path
ADDFOLDER=".legit/adds"
COMMITFOLDER=".legit/commits"
CLOGFILE=".legit/commits/commitLog"
CLOGTEMP=".legit/commits/commitLogTemp"

################### ARGUMENT CHECKING #########################################
# check if .legit folder exsists or nah
if ! [ -d .legit ]; then
    echo "legit-commit: error: no .legit directory containing legit repository exists" >&2
    exit 1
fi

# check if number of arguments are valid ie >= 1
if ( [ "$#" -lt 2 ] || [ "$#" -gt 3 ] ) ; then
    echo "usage: legit-commit [-a] -m commit-message" >&2
    exit 1
fi

aflag=0
# checks valiadility of commands
if ( [ "$#" -eq 3 ] && [ "$1" = "-a" ] && [ "$2" = "-m" ] ); then
    cmtMessage="$3"
    aflag=1
elif ( [ "$#" -eq 2 ] && [ "$1" = "-m" ] ); then
    cmtMessage="$2"
else
    echo "usage: legit-commit [-a] -m commit-message" >&2
    exit 1
fi
###############################################################################

################### FOLDER CONDITION SCREENING ################################
# get number of last commit
if ! [ -f "$CLOGFILE" ]; then
    commitNumber=0
else 
    latestCommit=$(head -n1 "$CLOGFILE" | cut -d' ' -f1)
    commitNumber=$(($latestCommit + 1))
fi

latestCommit=$( echo "$COMMITFOLDER/$latestCommit" )
# checking if adds folder has been updated or nah 
updateCounter=0
for file in "$ADDFOLDER"/*
do
    rootFile=$( basename "$file" )
    # if -a flag is triggered, add file from working directory to commits
    # we can add straight away because:
    # 1. if there isn't any changes, we will not be changing the files in staging folder
    # 2. if there are changes, the the commit should go through anyways
    if [ "$aflag" -eq 1 ]; then
        [ -f "$file" ] && legit-add.sh "$rootFile"
    fi 
    # test if add Folder is empty, if empty, file in $ADDFOLDER/* will
    # give * which is not a file
    ! [ -f "$file" ] && continue
    # if there isn't a file in latest commit folder that matches the file in staging folder, then this 
    # file must be freshly added. If there is a difference between this file and file with same name in latest commit
    # then we should add that to a fresh commit.
    if ( ! [ -f "$latestCommit/$rootFile" ] || ! cmp -s "$file" "$latestCommit/$rootFile" ); then
        updateCounter=$((updateCounter + 1))
    fi
done

# cross check between latest commit and adds folder to see if any file has been removed from add
deleteFlag=0
for file in "$latestCommit"/*
do
    # if commit folder is empty, file becomes * which is not a file
    ! [ -f "$file" ] && continue
    file=$( basename "$file" )
    if ! [ -f "$ADDFOLDER/$file" ]; then
        deleteFlag=1
    fi
done

# no new file/changed file/deleted file, then there is nothing to commit
if [ "$updateCounter" -eq 0 -a "$commitNumber" -ne 0 -a "$deleteFlag" -eq 0 ]; then
    echo "nothing to commit"
    exit 0
fi

# checking if is empty (has user added any files to be committed)
count=$(ls -l "$ADDFOLDER" | wc -l)
count=$(($count - 1))
# if nothing has been deleted and add file is empty then there is nothing to be committed
if [ $count -eq 0 -a "$deleteFlag" -eq 0 ]; then
    echo "nothing to commit"
    exit 0
fi
###############################################################################

############################ COMMIT CODE ######################################
# make directory
mkdir .legit/commits/"$commitNumber"

# write commit message to file
if [ "$commitNumber" -eq 0 ]; then
    echo "$commitNumber $cmtMessage" > "$CLOGFILE" 
else 
    echo "$commitNumber $cmtMessage" | cat - "$CLOGFILE" > "$CLOGTEMP"
    cat "$CLOGTEMP" > "$CLOGFILE"
    rm "$CLOGTEMP"
fi

# copies every file in adds to commits
for file in "$ADDFOLDER"/* 
do
    # if it's not a file then it must mean it's empty somehow
    if ! [ -f "$file" ]; then
        continue
    fi 

    [ -f "$file" ] && cp "$file" .legit/commits/"$commitNumber"
done

echo "Committed as commit $commitNumber"

###############################################################################