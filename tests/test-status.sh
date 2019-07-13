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

echo "==========LEGIT-STATUS TEST========\n"

rm -rf .legit/

echo "------------test 1------------"
echo

legit-init
echo a1 > a.txt
legit-add a.txt
legit-commit -m "a.txt"
echo "legit status: working == commit, working == add, add == commit"
legit-status

echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo b > a.txt
legit-add a.txt
echo c > a.txt
echo "legit status: working != commit, working != add, add != commit"
legit-status
echo

# ###################################################### #

echo "------------test 3-----------"
echo

legit-add a.txt
echo "legit-status: working != commit, working == add, add != commit"
legit-status
echo

# ###################################################### #

echo "------------test4------------"
echo
legit-commit -m "Lol"
echo d > a.txt
legit-add a.txt
echo c > a.txt
echo "legit-status: working == commit, working != add, add != commit"
legit-status
echo
####################################################### #

echo "------------test5------------"
echo

legit-rm --cached a.txt
echo "legit-status: working == commit, add is deleted"
legit-status
echo
####################################################### #

echo "------------test6------------"
echo

legit-add a.txt
rm a.txt
echo "legit-status: a.txt removed from working, commit == add"
legit-status
echo
####################################################### #

echo "------------test7------------"
echo

legit-rm a.txt
echo "legit-status: only add.txt in commit"
legit-status
echo
####################################################### #

echo "------------test8------------"
echo

echo anew > a.txt
legit-add a.txt
legit-commit -m "reead"
legit-rm --cached a.txt
echo asdf > a.txt
echo "legit-status: a.txt removed from add, working != commit"
legit-status
echo
# ####################################################### #

echo "------------test9------------"
echo

echo 12345 > a.txt
legit-add a.txt
legit-commit -m "lel"
echo asdf > a.txt
legit-add a.txt
rm a.txt
echo "legit-status: a.txt removed from working, add != commit"
legit-status
echo
# ####################################################### #

echo "------------test10------------"
echo

echo "trying to use legit-status without .legit/"
rm -rf .legit/
legit-status 2>&1
echo
# ####################################################### #

echo "------------test11------------"
echo

echo "trying to use legit-status without any commits/"
rm -rf .legit/
legit-init
echo lol > a.txt
legit-add a.txt
legit-status 2>&1
echo
# ####################################################### #

rm -rf .legit/
echo "====================================\n"



# for test_script in tests/*.sh
# do
#     export alias legit-add='2041 legit-add'
#     exp=`mktemp tmp/expXXXX.txt`
#     sh "$test_script" > "$exp"

#     export alias legit-add='legit-add.sh'
#     out=`mktemp tmp/outXXXX.txt`
#     sh "$test_script" > "$out"

#     diff $exp $out

# done