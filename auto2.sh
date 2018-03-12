rm -r beam.txt
rm -r beam1.txt

echo -e "\n The Source path is $1 \n The destination Path is $2"

a=`ls -Rt $1 | grep "\.beam" | wc -l`
b=`ls -Rt $1 | grep "\.beam"`

echo -e "\n Total no of erl files in $1 is $a."
echo $b | sed -e "s_\.beam_'\.\n_g" | sed "/../ s/ *\([^ ]*\)/'\1/" > beam.txt

a1=`ls -Rt $2 | grep "\.beam" | wc -l`
b1=`ls -Rt $2 | grep "\.beam"`

echo -e "\n Total no of erl files in $2 is $a1."
echo $b1 | sed -e "s_\.beam_'\.\n_g" | sed "/../ s/ *\([^ ]*\)/'\1/" > beam1.txt

export ERL_LIBS=$1

erl <tmp

echo -e "\n The Kaala is coming \n Thil iruntha mothamah vangaleah\n"

mv path1.txt path.txt

export ERL_LIBS=$2

erl <tmp1

echo -e "\n The Kaala means black, God of death Kaarikalan\n"

erl <tmp2
