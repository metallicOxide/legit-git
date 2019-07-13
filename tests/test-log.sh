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

echo "==========LEGIT-LOG TEST========\n"

rm -rf .legit/
echo "------------test 1------------"
echo

echo "1 commit"
legit-init
echo a > a.txt
legit-add a.txt
legit-commit -m "log one"
legit-log
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo "2 commits"
legit-init
echo a > a.txt
legit-add a.txt
legit-commit -m "log one"
echo b > a.txt
legit-commit -a -m "log two"
legit-log
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 3-----------"
echo

echo "20 commits"
legit-init
echo a > a.txt
legit-add a.txt
legit-commit -m "log 0"

echo "committing 20 times with different changes"
i=1
while [ "$i" -lt 20 ];
do
    echo "$1" > a.txt
    legit-commit -a -m "log $1"
done

legit-log
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 4-----------"
echo

echo "running legit-log with multiple arguments"
legit-init
echo a > a.txt
legit-add a.txt
legit-commit -m "log one"
legit-log
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 5-----------"
echo

echo "running legit-log without any commits"
legit-init
legit-log
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 4-----------"
echo

echo "running legit-log without .legit folder"
legit-log

echo
# ###################################################### #
echo "====================================\n"

