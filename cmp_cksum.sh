rm -f beam.txt
rm -f beam1.txt

dir=`pwd`

echo -e "\nThe source Path is $1 \n The destination path is $2"

a=`ls -Rt $1 | grep "\.beam" | wc -l`
b=`ls -Rt $1 | grep "\.beam"`

echo -e "\nTotal no of beam files in $1 is $a. \\n"
echo $b | sed -e "s_\.beam_'\.\n_g" | sed "/../ s/ *\([^ ]*\)/'\1/" > beam.txt

a1=`ls -Rt $2 | grep "\.beam" | wc -l`
b1=`ls -Rt $2 | grep "\.beam"`

echo -e "\nTotal no of beam files in $1 is $a1. \\n"
echo $b1 | sed -e "s_\.beam_'\.\n_g" | sed "/../ s/ *\([^ ]*\)/'\1/" > beam1.txt

cd $1

check=`cksum $b | cut -d " " -f 1,3`
echo -e "\n$check\n\n" 
echo -e "\"$check\"." > $dir/tmp_cksum.txt
cd

cd $2

check2=`cksum $b1 | cut -d " " -f 1,3`
echo -e "\n$check2\n\n" 
echo -e "\"$check2\"." > $dir/tmp_cksum1.txt
cd

erl <tmp_cmp_cksum

mv path7.txt path8.txt

erl <tmp_cmp_cksum1

erl <tmp_cmp_cksum2

echo -e "\nThese files output's are in your Output path as output_in_txt_file_(date).txt file. \n"

echo -e "\n ****************** Kaala da \m/ ********\n "




