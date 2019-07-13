#!/bin/dash

if [ "$1" -eq 2041 ]; then
    alias legit-add='2041 legit-add'
    alias legit-init='2041 legit-init'
    alias legit-commit='2041 legit-commit'
    alias legit-status='2041 legit-status'
    alias legit-rm='2041 legit-rm'
    alias legit-log='2041 legit-log'
    alias legit-show='2041 legit-show'
fi

if [ "$1" -eq 0 ]; then
    alias legit-add='legit-add.sh'
    alias legit-init='legit-init.sh'
    alias legit-commit='legit-commit.sh'
    alias legit-status='legit-status.sh'
    alias legit-rm='legit-rm.sh'
    alias legit-log='legit-log.sh'
    alias legit-show='legit-show'
fi

echo "==========LEGIT-ADD TEST========\n"
rm -rf .legit/
echo "------------test 1------------"
echo

echo "add a normal file to index"
legit-init
rm -f a.txt
echo sample > a.txt
legit-add a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo "add file that already exsists into index"
legit-init
rm -f a.txt
echo sample > a.txt
legit-add a.txt
legit-add a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 3-----------"
echo

echo "add same file multiple times on same line"
legit-init
rm -f a.txt
echo sample > a.txt
legit-add a.txt a.txt a.txt 
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 4-----------"
echo

echo "add file that does not exsist"
legit-init
rm -f a.txt
legit-add a.txt 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 5-----------"
echo

echo "add with # in name"
legit-init
echo sample > "a#.txt"
legit-add "a.!txt" 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 6-----------"
echo

echo "add with . in front of name"
legit-init
echo sample > ".a.txt"
legit-add ".a.txt" 2>&1
rm -rf .legit/


echo
# ###################################################### #
echo "------------test 7-----------"
echo

echo "add a directory into add folder"
legit-init
rm -rf a
mkdir a
legit-add a 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 8-----------"
echo

echo "add valid file with weird name"
legit-init
rm -f Awe1RdName._-.txt
legit-add Awe1RdName._-.txt 2>&1
rm -rf .legit/

echo
# ###################################################### #

echo "------------test 9-----------"
echo

echo "add file without .legit/ directory"
echo lol > a.txt
legit-add a.txt
rm -rf .legit/

echo
# ###################################################### #

echo "------------test 10-----------"
echo

echo "add file, change file, add file"
legit-init
echo lol > a.txt
legit-add a.txt
echo change > a.txt
legit-add a.txt
rm -rf .legit/

echo
# ###################################################### #

echo "------------test 11-----------"
echo

echo "add file, rm file, add file"
legit-init
echo lol > a.txt
legit-add a.txt
rm a.txt
legit-add a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 12-----------"
echo

echo "add multiple files"
legit-init
echo lol > a.txt
echo b > b.txt
legit-add a.txt b.txt
rm a.txt b.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 12-----------"
echo

echo "wild card"
legit-init
legit-add *
rm a.txt b.txt
rm -rf .legit/

echo
# ###################################################### #
echo "====================================\n"


