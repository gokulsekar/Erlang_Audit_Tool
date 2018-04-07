echo -e "\n The source Path is $1 \n The destination path is $2 \n The output path is $3 \n"

a=`ls -Rt $1 | grep "\.beam" | wc -l`
b=`ls -Rt $1 | grep "\.beam"`
echo -e "\n Total no of beam files in $1 is $a."
#echo -e "\\n They are \n$b"

a1=`ls -Rt $2 | grep "\.beam" | wc -l`
b1=`ls -Rt $2 | grep "\.beam"`
echo -e "\n Total no of beam files in $2 is $a1."
#echo -e "\n They are \n$b1\n\n"

Identical=`diff -sr $1 $2 | grep "\.beam" | grep identical `
Differ=`diff -sr $1 $2 | grep "\.beam" | grep differ`
Only1=`diff -sr $1 $2 | grep "\.beam" | grep Only | grep $1`
Only2=`diff -sr $1 $2 | grep "\.beam" | grep Only | grep $2`

d=`date "+%d_%m_%y"`

rm -f $3/audit_cmp_beam_output_$d.txt 

if [ "$Identical" != "" ]; then
echo -e "\nThese files are same \nThey are \n$Identical." >>$3/audit_cmp_beam_output_$d.txt
fi

if [ "$Differ" != "" ]; then
echo -e "\n\nThese files are differ \nThey are \n$Differ. " >>$3/audit_cmp_beam_output_$d.txt
fi

if [ "$Only1" != "" ]; then
echo -e "\n\nThese files are Only in $1 \nThey are \n$Only1. " >>$3/audit_cmp_beam_output_$d.txt
fi

if [ "$Only2" != "" ]; then
echo -e "\n\nThese files are Only in $2 \nThey are \n$Only2. " >>$3/audit_cmp_beam_output_$d.txt
fi