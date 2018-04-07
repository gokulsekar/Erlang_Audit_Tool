rm -f beam.txt
rm -f beam1.txt

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

erl <tmp_cmp_cid

mv path3.txt path2.txt

export ERL_LIBS=$2

erl <tmp_cmp_cid1

erl <tmp_cmp_cid2

echo -e "\n These files output's are in ur Output path as output_in_txt_file_(date).txt file. \n"

