#!/bin/bash
echo -e "\e[0;35m"
    myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`
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