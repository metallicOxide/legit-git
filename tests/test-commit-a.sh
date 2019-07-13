#!/bin/dash

if [ "$1" -eq 0 ]; then
    alias legit-add='legit-add.sh'
    alias legit-init='legit-init.sh'
    alias legit-commit='legit-commit.sh'
    alias legit-status='legit-status.sh'
    alias legit-rm='legit-rm.sh'
    alias legit-log='legit-log.sh'
    alias legit-show='legit-show.sh'
fi

if [ "$1" -eq 2041 ]; then
    alias legit-add='2041 legit-add'
    alias legit-init='2041 legit-init'
    alias legit-commit='2041 legit-commit'
    alias legit-status='2041 legit-status'
    alias legit-rm='2041 legit-rm'
    alias legit-log='2041 legit-log'
    alias legit-show='2041 legit-show'
fi

echo "==========LEGIT-COMMIT -A TEST========\n"

rm -rf .legit/
echo "------------test 1------------"
echo

echo "running commit -a without .legit"
legit-commit -a -m "yes"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo "running commit -a without any files in add"
legit-init
legit-commit -a -m "try this"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 3-----------"
echo

echo "running commit -a without any changes to file"
legit-init
rm -f a.txt
echo a > a.txt
legit-add a.txt
legit-commit -a -m "test commit"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 4-----------"
echo

echo "running commit -a twice without changes to file"
legit-init
rm -f a.txt
echo a > a.txt
legit-add a.txt
legit-commit -a -m "commit 0"
legit-commit -a -m "commit 1"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 5-----------"
echo

echo "running commit -a twice with changes to file"
legit-init
rm -f a.txt
echo a > a.txt
legit-add a.txt
legit-commit -m "commit 0"
echo "showing a.txt in commit 0"
legit-show 0:a.txt
echo b > a.txt
legit-commit -m "commit 1"
echo "showing a.txt in commit 1"
legit-show 1:a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 6-----------"
echo

echo "running commit -a x 2: commit != add, add != file"
legit-init
rm -f a.txt
echo a > a.txt
legit-add a.txt
legit-commit -a -m "commit 0"
echo "showing a.txt in commit 0"
legit-show 0:a.txt
echo b > a.txt
echo "changed content of a.txt to b"
legit-add a.txt
echo "showing a.txt in index"
legit-show :a.txt
echo "changed content of a.txt to c"
echo c > a.txt
legit-commit -a -m "commit 1"
echo "showing a.txt in commit 1"
legit-show 1:a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 7-----------"
echo

echo "running commit -a with two updated files"
legit-init
echo sample > a.txt
echo samepl1 > b.txt
legit-add a.txt b.txt
legit-commit -a -m "successful commit"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 8-----------"
echo

echo "running commit with empty add after removing all"
legit-init
rm -rf a.txt
echo a > a.txt
echo b > b.txt
legit-add a.txt b.txt
legit-commit -a -m "commit 0"
rm a.txt b.txt
legit-commit -a -m "should be sucessful"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 9-----------"
echo

echo "running commit with empty add after removing some files"
legit-init
rm -rf a.txt
echo a > a.txt
echo b > b.txt
legit-add a.txt b.txt
legit-commit -a -m "commit 0"
rm a.txt
legit-commit -a -m "should be sucessful"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 10-----------"
echo

echo "running commit with empty add after removing some files"
legit-init
rm -rf a.txt
echo a > a.txt
echo b > b.txt
legit-add a.txt b.txt
legit-commit -a -m "commit 0"
rm a.txt
legit-commit -a -m "should be sucessful"
echo "run commit again, nothing to commit"
legit-commit -a -m "should be unsucessful"
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 11-----------"
echo

echo "running commit with different flags -s"
legit-init
echo sample > a.txt
legit-add a.txt
legit-commit -a -m -s "unsuccessful commit" 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 12-----------"
echo

echo "running commit without message"
legit-init
echo sample > a.txt
legit-add a.txt
legit-commit -a -m 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 13-----------"
echo

echo "running commit with extra flags"
legit-init
echo sample > a.txt
legit-add a.txt
legit-commit -a -m -s "unsuccessful commit" 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "====================================\n"


