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

echo "==========LEGIT-INIT TEST========\n"

rm -rf .legit/
echo "------------test 1------------"
echo

echo "valid init"
legit-init
rm -rf .legit/
echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo "run init when .legit exsists"
legit-init
legit-init 2>&1
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 3-----------"
echo

echo "run init with one arguments"
legit-init "arg1" 2>&1

echo
# ###################################################### #
echo "------------test 4-----------"
echo

echo "run init with multiple arguments"
legit-init "arg1" "arg2" "arg3" 2>&1

echo
# ###################################################### #
echo "====================================\n"

