#!/bin/bash

mkdir Database 2>> ./error
clear

echo "Welcom to our project "

function main_menu {

echo "Let's check DBMS "
echo "---------------------------------------"
echo "	Main Menu             "
echo "	1- Disply Databases   "
echo "	2- Select Database    "
echo "	3- Create Database    "
echo "	4- Drop Database      "
echo "	5- Exit               "
echo "---------------------------------------"
echo " Enter Your Choice:  "
read num
case $num in

	1) ls ./Database ; main_menu
	;;
	2) Select_Database 
	;;
    	3) Create_Database 
	;;
    	4) Drop_Database 
	;;
    	5) exit 
	;;
    	*) echo " Wrong Choice " ; main_menu;
  
esac

}


function Create_Database {

echo "Enter Database Name: "
read DataBase_Name
mkdir ./Database/$DataBase_Name
  	
	if [[ $? == 0 ]]
  	then
    		echo "Database $DataBase_Name Created"
  	else
    		echo "Error Creating Database"
  	fi
	main_menu
  		
}

function Select_Database {

echo "Enter Database Name: "
read DataBase_Name
cd ./Database/$DataBase_Name 2>> ./error
	
	if [[ $? == 0 ]];
	then
    
		echo "Database $DataBase_Name was Successfully Selected"
    		second_menu
  
	else
    		echo "Database $DataBase_Name wasn't found"
    		main_menu
  	fi

}

function Drop_Database {

echo "Enter Database Name: "
read DataBase_Name
rm -r ./Database/$DataBase_Name 2>> ./error
  
	if [[ $? == 0 ]]; then
    		echo "Database $DataBase_Name Dropped Successfully"
  	else
    		echo "Database Not found"
  	fi
  		main_menu

}

main_menu
