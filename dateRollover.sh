#!/bin/bash
#Date change script in DFLAG and post can run batchScipt with new date
#And have option to previous date (stored in the same file)

filePath="data/file/DFLAG"


#Function defination 
loading(){
	echo -e -n "\033[1;36mChanging DFLAG"
	for i in `seq 1 10`
	do
		echo -n '.'
		sleep 0.04
	done
	echo -e "\033[1;0m";
}

postJob(){
  echo "Executing Post job";
  echo "Post job Execution done";
}


#Main Execution start here
od="20230707"
pd=`cat $filePath | cut -b 9-16`

echo "presentdate is $pd";
echo "previousdate was $od";
echo -e "\033[1;36mEnter New Date, Format (YYYYMMDD):\033[1;0m";
read nd;

##Validatotion
dw=$(( $(echo $nd | wc -c) - 1))
if [ -z $nd ] | [ $dw -ne 8 ]
then
	echo -e "\033[1;31mEnter date is Wrong\033[1;0mHHHHH"; exit;
fi
echo -n "DFLAG Value :   ";cat $filePath;

#Loading animation
loading

sleep 1
sed -i s/$pd/$nd/g $filePath
echo -n "DFLAG Value :   ";cat $filePath
echo -e "\033[1:36m
Y : EXECUTE_JOB 
N : NOT EXECUTE JOB and EXIT 
R : REVERT DATE TO PREVIOUS DATE 
\033[1;0m"

read FLAG
if [[ $FLAG == 'Y' ]];
then
	sed -i "s/$od/$pd/g" $0
	postJob #Execute post job
	echo -e "\033[1;32mDATE ROLLOVER COMPLETE \033[1;0m\n"
elif [[ $FLAG == 'R' ]];
then
	echo "Reverting DFLAG to PrevDt"

	sed -i s/$nd/$pd/g $filePath
	echo -n "DFLAG Value :   "; cat $filePath
else
	echo -e "\033[1;32m DFLAG Changed $nd \033[1;0m"
	sed -i "s/$od/$pd/g" $0
fi

exit 0;
