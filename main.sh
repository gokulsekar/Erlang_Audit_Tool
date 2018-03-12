echo -e "\n Hii Mates,\n "

h=`date +"%H"`

if [ $h -ge 0 ] && [ $h -lt 12 ]
then

echo " Good Moring to all"

elif [ $h -ge 12 ] && [ $h -lt 18 ]
then

echo " Good Afternoon to all"

else
echo " Good Evening to all"

fi

echo -e "\n The usage of the script is to reduce the manual audit work & stress also :) \n"
echo -e " Menu \n  1 for Compare the beam file. \n  2 for Compare the erl file. \n  3 for Compare the both Version and Commit_Id. \n  4 for Compare only the Commit_Id. \n  5 for Compare only the Version. \n  6 for Exit. \n\n Please enter the number from 1 to 6. \n "

read c

if test $c -eq 1
then
echo -e "\n Please enter the Source Path"
read s
echo -e "\n Please enter the Destination Path"
read d
echo -e "\n You select 1. \n The script going to run \n"
sh auto.sh $s $d
echo -e "\n Hakuna matata"

elif test $c -eq 2
then
echo -e "\n Please enter the Source Path"
read s
echo -e "\n Please enter the Destination Path"
read d
echo -e "\n You select 2. \n The script going to run \n"
sh auto1.sh $s $d
echo -e "\n Hakuna matata"

elif test $c -eq 3
then
echo -e "\n Please enter the Source Path"
read s
echo -e "\n Please enter the Destination Path"
read d
echo -e "\n You select 3. \n The script going to run \n"
sh auto2.sh $s $d
echo -e "\n Hakuna matata"

elif test $c -eq 4
then
echo -e "\n Please enter the Source Path"
read s
echo -e "\n Please enter the Destination Path"
read d
echo -e "\n You select 4. \n The script going to run \n"
sh auto3.sh $s $d
echo -e "\n Hakuna matata"

elif test $c -eq 5
then
echo -e "\n Please enter the Source Path"
read s
echo -e "\n Please enter the Destination Path"
read d
echo -e "\n You select 5. \n The script going to run \n"
sh auto4.sh $s $d
echo -e "\n Hakuna matata"

elif test $c -eq 6
then
echo -e "\n You select 6. \n Hakuna matata"
exit 0

else
echo "\n Please enter the vaild option"

fi

