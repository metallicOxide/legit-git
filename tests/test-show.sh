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

echo "==========LEGIT-SHOW TEST========\n"

rm -rf .legit/

echo "------------test 1------------"
echo

echo "test index"
legit-init
echo "input a1 to a.txt"
echo a1 > a.txt
echo "added a.txt to index and commited change"
legit-add a.txt
legit-commit -m "a.txt"
echo "showing a.txt in legit index"
legit-show :a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo "test commit"
legit-init
echo "input a1 to a.txt"
echo a1 > a.txt
echo "added a.txt to index and commited change"
legit-add a.txt
legit-commit -m "a.txt"
echo "showing a.txt in legit index"
legit-show :a.txt
echo "showing a.txt in commit"
legit-show 0:a.txt
rm -rf .legit/


echo
# ###################################################### #
echo "------------test 3-----------"
echo

echo "test show index after removing a.txt from directory"
legit-init
echo "input a1 to a.txt"
echo a1 > a.txt
echo "added a.txt to index and commited change"
legit-add a.txt
legit-commit -m "a.txt"
echo "showing a.txt in legit index"
legit-show :a.txt
echo "removing a.txt"
rm a.txt
echo "showing a.txt in index after removal"
legit-show :a.txt
rm -rf .legit/

echo
# ###################################################### #
echo "------------test4------------"
echo

echo "test show commit after removing a.txt from directory"
legit-init
echo "input a1 to a.txt"
echo a1 > a.txt
echo "added a.txt to index and commited change"
legit-add a.txt
legit-commit -m "a.txt"
echo "showing a.txt in commit"
legit-show 0:a.txt
echo "removing a.txt"
rm a.txt
echo "showing a.txt in commit after removal"
legit-show 0:a.txt
rm -rf .legit/

echo
####################################################### #

echo "------------test5------------"
echo

echo "test show multiple commits"
legit-init
echo "input a1 to a.txt"
echo a1 > a.txt
echo "added a.txt to index and commited change"
legit-add a.txt
legit-commit -m "a.txt"
echo "showing a.txt in commit"
legit-show 0:a.txt
echo change a > a.txt
legit-commit -a -m change
echo "showing a.txt in commit 1"
legit-show 1:a.txt
echo "showing a.txt in index"
legit-show :a.txt
rm -rf .legit/

echo
####################################################### #

echo "------------test6------------"
echo

echo "legit show with no arguments"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show
rm -rf .legit/

echo
####################################################### #

echo "------------test7------------"
echo

echo "legit show with only :"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show :
rm -rf .legit/

echo
####################################################### #

echo "------------test8------------"
echo

echo "legit show with only commit:"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show 0: 2>&1
rm -rf .legit/

echo
# ####################################################### #

echo "------------test9------------"
echo

echo "legit show with unknown commit"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show 99:a.txt 2>&1
rm -rf .legit/

echo
# ####################################################### #

echo "------------test10------------"
echo

echo "legit show with unkown file in commit"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show 0:qweqweq.txt 2>&1
rm -rf .legit/

echo
# ####################################################### #
echo "------------test11------------"
echo

echo "legit show with unkown file in index"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show :qweqweq.txt 2>&1
rm -rf .legit/

echo
# ####################################################### #
echo "------------test12------------"
echo

echo "legit show with invalid argument"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show invaliddddd 2>&1
rm -rf .legit/

echo
# ####################################################### #
echo "------------test13------------"
echo

echo "legit show with multiple arguments"
legit-init
echo l > a.txt
legit-add a.txt 
legit-commit -m "yes"
legit-show 0:a.txt 0:a.txt 2>&1
rm -rf .legit/

echo
# ####################################################### #
echo "------------test14------------"
echo

echo "legit show without any commits"
legit-init
legit-show  2>&1
rm -rf .legit/

echo
# ####################################################### #
echo "------------test15------------"
echo

echo "legit show without .legit/"

legit-show  2>&1

echo
# ####################################################### #

rm -rf .legit/
echo "====================================\n"