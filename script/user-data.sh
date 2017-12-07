#!/bin/bash
echo -e "\e[0;35m"
    myip=`wget -qO- ifconfig.co`
	myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`
	ifconfig $myint | grep "RX bytes" | sed -e 's/ *RX [a-z:0-9]*/Received: /g' | sed -e 's/TX [a-z:0-9]*/\nTransfered: /g'
    echo -e "\e[0;34m"
    	read -p "Press enter back to " -e -i menu option1
	case $option1 in
        menu)
		clear
        menu
		exit
		;;
	esac
done