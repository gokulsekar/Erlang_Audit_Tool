echo -e "\n The source Path is $1 \n The destination path is $2"

a=`ls -Rt $1 | grep "\.erl" | wc -l`
b=`ls -Rt $1 | grep "\.erl"`
echo -e "\n Total no of erl files in $1 is $a. \\n They are \n$b"

a1=`ls -Rt $2 | grep "\.erl" | wc -l`
b1=`ls -Rt $2 | grep "\.erl"`
echo -e "\n Total no of erl files in $2 is $a1. \n They are \n$b1\n\n"

Identical=`diff -sr $1 $2 | grep "\.\erl" | grep identical `
Differ=`diff -sr $1 $2 | grep "\.erl" | grep differ`
Only1=`diff -sr $1 $2 | grep "\.erl" | grep Only | grep $1`
Only2=`diff -sr $1 $2 | grep "\.erl" | grep Only | grep $2`

if [ "$Identical" != "" ]; then
echo -e "\n\n These files are same \n$Identical"
fi

if [ "$Differ" != "" ]; then
echo -e "\n\n These files are differ \n$Differ. "
fi

if [ "$Only1" != "" ]; then
echo -e "\n\n These files are Only in $1 \n They are \n$Only1 "
fi

if [ "$Only2" != "" ]; then
echo -e "\n\n These files are Only in $2 \n They are \n$Only2 "
fi

