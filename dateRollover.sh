#!/bin/bash
#Date change script in DFLAG and post can run batchScipt with new date
#And have option to previous date (stored in the same file)

filePath="data/file/DFLAG"

#------------------------------------------------------------------------------------------------------------  
#Function defination 
#------------------------------------------------------------------------------------------------------------  

#Loading Animation Function
loading(){
	for i in `seq 1 10`
	do
		echo -n '.'
		sleep 0.04
	done
	echo -e "\033[1;0m";
}

#Declare post script here 
postJob(){
  echo "Executing Post job";
  echo "Post job Execution done";
}


#Function to change font color
color(){

case $1 in 
  BLACK|B)
    tput setaf 0 ;;
  RED|R)
    tput setaf 1 ;;
  GREEN|G)
    tput setaf 2 ;;
  YELLOW|Y)
    tput setaf 3 ;;
  BLUE|BL)
    tput setaf 4 ;;
  VIOLET|V)
    tput setaf 5 ;;
  LIGHTBLUE|LB)
    tput setaf 6 ;;
  WHITE|W)
    tput setaf 7 ;;
  *)
   echo "Usage $0 {B|G|Y|BL|V|LB|W}"
   exit 1 ;;
esac
}


#------------------------------------------------------------------------------------------------------------  
#Main Execution start here
#------------------------------------------------------------------------------------------------------------  
previousdate=""
presentDate=`cat $filePath | cut -b 9-16`

color W;
echo "****************************************"
echo "presentdate is   - $presentDate";
echo "previousdate was - $previousdate";
echo -n "DFLAG Value      - ";cat $filePath;
echo "****************************************"

color LB;echo "Enter New Date, Format (YYYYMMDD): ";color W;

read nextDate;

#Validate Date length and 
if ! date -d $nextDate  +"%Y%m%d" >/dev/null 2>&1 || [[ ${#nextDate} -ne 8 ]]; then
  color R; echo -e "Enter date is Wrong";exit
fi


#Loading animation
color LB;echo -n "Changing DFLAG";
loading
color W;

sed -i s/$presentDate/$nextDate/g $filePath
echo -n "DFLAG Value :   ";cat $filePath
color LB
echo -e "
Y : EXECUTE_JOB 
N : NOT EXECUTE JOB and EXIT 
R : REVERT DATE TO PREVIOUS DATE 
"
color W

read FLAG

case $FLAG in 
Y) 
  sed -i s/$previousdate/$presentDate/g $0
  postJob #Execute post job
  color G;echo -e "DATE ROLLOVER COMPLETE\n";color W;
;;
R)
  color LB;echo "Reverting DFLAG to PrevDt"
  sed -i s/$nextDate/$presentDate/g $filePath
  color W;echo -n "DFLAG Value :   "; cat $filePath
;;
N|*)
  color G;echo -e "DFLAG Changed $nextDate\n";color W
  sed -i "s/$previousdate/$pd/g" $0
;;
esac
