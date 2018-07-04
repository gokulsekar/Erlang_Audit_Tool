echo -e "\n*******************************************************************************************************************************************************
\n********************************************************************** Welcome To Audit Automation Tool ***********************************************
\n*******************************************************************************************************************************************************"

echo -e "\nHii Mates,\n "

echo -e "\nThe usage of the script is to reduce the manual audit work & stress also :) \n"
echo -e "Menu \n  1 for Compare the beam file. \n  2 for Compare the erl file. \n  3 for Compare the both Erlang Version and Commit_Id. \n  4 for Compare only the Commit_Id. \n  5 for Compare only the Erlang Version. \n  6 for Compare the cksum of the beam. \n  7 for Exit. \n\nPlease enter the number from 1 to 7. \n "

read c

for ((ch=0;ch<3;ch++))
do

if expr "$c" : '[0-9][0-9]*$'>/dev/null; then

if [[ $c -ge 1 && $c -le 6 ]];
then
echo -e "\nvalid choice"
ch=3
echo -e "\nEnter the Source path"

read Source_path

for ((i=0;i<3;i++))
do
if [ ! -d "$Source_path" ]
then
        echo -e "\nDirectory does not exist! \n\nEnter the Source path"
        read Source_path

elif [ -d "$Source_path" ]
then
        echo -e "\nEnter the Destination path"
        i=3
		read Destination_path
		
		for ((j=0;j<3;j++))
		do
		if [ ! -d "$Destination_path" ]
		then
				echo -e "\nDirectory does not exist! \n\nEnter the Destination path"
				read Destination_path
		
		elif [ -d "$Destination_path" ]
		then
				if [ "$Source_path" != "$Destination_path" ]
				then
					echo -e "\nEnter the Output path"
					j=3
					read Output_path
					
					for ((k=0;k<3;k++))
					do
					if [ ! -d "$Output_path" ]
					then
							echo -e "\nDirectory does not exist!  \nEnter the Output path"
							read Output_path
					
					elif [ -d "$Output_path" ]
					then
							k=3
							rm -f directory_path.txt
							echo -e "'$Source_path'.\n" >>directory_path.txt
							echo -e "'$Destination_path'.\n" >>directory_path.txt
							echo -e "'$Output_path'.\n" >>directory_path.txt
							if test $c -eq 1 >/dev/null
							then
							echo -e "\nYou select 1. \nThe script is running \n"
							sh cmp_beam.sh $Source_path $Destination_path $Output_path >/dev/null
							echo -e "\n"
							
							elif test $c -eq 2 >/dev/null
							then
							echo -e "\nYou select 2. \nThe script is running \n"
							sh cmp_erl.sh $Source_path $Destination_path $Output_path >/dev/null
							echo -e "\n"
							
							elif test $c -eq 3 >/dev/null
							then
							echo -e "\nYou select 3. \nThe script is running \n"
							sh cmp_erlang_version_and_commit_id.sh $Source_path $Destination_path >/dev/null
							echo -e "\n"
							
							elif test $c -eq 4 >/dev/null
							then
							echo -e "\nYou select 4. \nThe script is running \n"
							sh cmp_commit_id.sh $Source_path $Destination_path >/dev/null
							echo -e "\n"
							
							elif test $c -eq 5 >/dev/null
							then
							echo -e "\nYou select 5. \nThe script is running \n"
							sh cmp_erlang_version.sh $Source_path $Destination_path >/dev/null
							echo -e "\n"
							
							elif test $c -eq 6 >/dev/null
							then
							echo -e "\nYou select 6. \nThe script is running \n"
							sh cmp_cksum.sh $Source_path $Destination_path >/dev/null
							echo -e "\n"
							
							else
							echo "\nPlease enter the vaild option"
							
							fi
							
					fi
					done
				else
				echo -e "\nBoth the Source path and Destination Path are same.\n"
				echo -e "\n********************************* If any concern please, sent an email to sourav.ghatak@ee.co.uk/sourav_ghatak@thbs.com or gokul_sekar@thbs.com ********************************\n"
				exit 0
				fi					
					
		fi
		done
fi
done

elif test $c -eq 7 >/dev/null
then
echo -e "\nGoing to exit"
echo -e "\n************************** If any concern please, sent an email to sourav.ghatak@ee.co.uk/sourav_ghatak@thbs.com or gokul_sekar@thbs.com **************\n"
exit 0

elif [[ $c -ge 8 || $c -eq 0 ]];
then
echo -e "\nEnter the number from 1 to 7 only"
read c

fi

else
echo -e "\nPlease, enter the number only in integer"
read c

fi
done


echo -e "\n********************************* If any concern please, sent an email to sourav.ghatak@ee.co.uk/sourav_ghatak@thbs.com or gokul_sekar@thbs.com ***********************\n"