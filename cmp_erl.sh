echo -e "\n The source Path is $1 \n The destination path is $2 \n The output path is $3 \n"

cp=`pwd`

echo -e "$cp"
cd $1

mkdir -p source_beam
sbp=$1/source_beam
echo -e "$sbp"
cp lib/*/ebin/*.beam ./source_beam >null
cd $cp
cp ./beam_to_erl.erl $1/source_beam/ >null
cp ./tmp_convert $1/source_beam/
convert_source_path=$1/source_beam/
echo -e "'$convert_source_path'".>$sbp/source_path.txt
cd $sbp
erl <tmp_convert
echo -e "kaala"

cd $2

mkdir -p destination_beam
dbp=$2/destination_beam
echo -e "$dbp"
cp lib/*/ebin/*.beam ./destination_beam >null
cd $cp
cp ./beam_to_erl.erl $2/destination_beam/ >null
cp ./tmp_convert1 $2/destination_beam/
convert_destination_path=$2/destination_beam/
echo -e "'$convert_destination_path'".>$dbp/destination_path.txt
cd $dbp
erl <tmp_convert1
echo -e "kaala"

a=`ls -Rt $sbp | grep "\.erl" | wc -l`
b=`ls -Rt $sbp | grep "\.erl"`
echo -e "\n Total no of erl files in $sbp is $a."
#echo -e "\n They are \n$b"

a1=`ls -Rt $dbp | grep "\.erl" | wc -l`
b1=`ls -Rt $dbp | grep "\.erl"`
echo -e "\n Total no of erl files in $dbp is $a1." 
#echo -e "\n They are \n$b1\n\n"

Identical=`diff -sr $sbp $dbp | grep "\.erl" | grep identical `
Differ=`diff -qr $sbp $dbp | grep "\.erl" | grep differ`
Only1=`diff -sr $sbp $dbp | grep "\.erl" | grep Only | grep $sbp`
Only2=`diff -sr $sbp $dbp | grep "\.erl" | grep Only | grep $dbp`

d=`date "+%d_%m_%y"`

rm -f $3/audit_cmp_erl_output_$d.txt

if [ "$Identical" != "" ]; then
echo -e "\nThese files are same \n$Identical" >>$3/audit_cmp_erl_output_$d.txt
fi

if [ "$Differ" != "" ]; then
echo -e "\nThese files are differ \n$Differ. " >>$3/audit_cmp_erl_output_$d.txt
fi

if [ "$Only1" != "" ]; then
echo -e "\nThese files are Only in $sbp \nThey are \n$Only1 " >>$3/audit_cmp_erl_output_$d.txt
fi

if [ "$Only2" != "" ]; then
echo -e "\nThese files are Only in $dbp \nThey are \n$Only2 " >>$3/audit_cmp_erl_output_$d.txt
fi

