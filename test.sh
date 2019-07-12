#!/bin/dash

echo "------------test 1------------"
echo

2041 legit-init
echo a1 > a.txt
2041 legit-add a.txt
2041 legit-commit -m "a.txt"
echo "legit status: working == commit, working == add, add == commit"
2041 legit-status
echo
# ###################################################### #
echo "------------test 2-----------"
echo

echo b > a.txt
2041 legit-add a.txt
echo c > a.txt
echo "legit status: working != commit, working != add, add != commit"
2041 legit-status
echo

# ###################################################### #

echo "------------test 3-----------"
echo

2041 legit-add a.txt
echo "legit-status: working != commit, working == add, add != commit"
2041 legit-status
echo

# ###################################################### #

echo "------------test4------------"
echo
2041 legit-commit -m "Lol"
echo d > a.txt
2041 legit-add a.txt
echo c > a.txt
echo "legit-status: working == commit, working != add, add != commit"
2041 legit-status
echo
####################################################### #

echo "------------test5------------"
echo

2041 legit-rm --cached a.txt
echo "legit-status: working == commit, add is deleted"
2041 legit-status
echo
####################################################### #

echo "------------test6------------"
echo

2041 legit-add a.txt
rm a.txt
echo "legit-status: a.txt removed from working, commit == add"
2041 legit-status
echo
####################################################### #

echo "------------test7------------"
echo

2041 legit-rm a.txt
echo "legit-status: only add.txt in commit"
2041 legit-status
echo
####################################################### #

echo "------------test8------------"
echo

echo anew > a.txt
2041 legit-add a.txt
2041 legit-commit -m "reead"
2041 legit-rm --cached a.txt
echo asdf > a.txt
echo "legit-status: a.txt removed from add, working != commit"
2041 legit-status
echo
# ####################################################### #

echo "------------test9------------"
echo

echo 12345 > a.txt
2041 legit-add a.txt
2041 legit-commit -m "lel"
echo asdf > a.txt
2041 legit-add a.txt
rm a.txt
echo "legit-status: a.txt removed from working, add != commit"
2041 legit-status
echo
# ####################################################### #

rm -rf .legit/



for test_script in tests/*.sh
do
    export alias legit-add='2041 legit-add'
    exp=`mktemp tmp/expXXXX.txt`
    sh "$test_script" > "$exp"

    export alias legit-add='legit-add'
    out=`mktemp hbhjbcjs`
    sh lfkhv > $out

    diff $exp $out



done