#!/bin/bash
myip=`curl ifconfig.me`;
#myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
flag=0
echo
if [ $USER != 'root' ]; then
	echo "Sorry, for run the script please using root user"
	exit
fi



	clear
    echo ""
    echo -e "\e[0;35m                          PPTP-VPN USER OPTION\e[0m"
    echo -e "\e[0;34m                         -------ooooOAOooo------\e[0m"
	echo -e "\e[0;35m 1)\e[0m Create new pptp user                (add pptp user)"
    echo -e "\e[0;35m 2)\e[0m Check pptp user details             (pptp user list)"
    echo -e "\e[0;35m 3)\e[0m Deleted pptp-vpn user               (pptp user delete)"
	echo -e "\e[0;35m 4)\e[0m User pptp expired list              (user pptp expired list)"
    echo -e "\e[0;35m 5)\e[0m Exit                                (logout)"
    echo ""
	read -p "Select an option from [1-5] than press ENTER: " option1
	case $option1 in
		1)
		clear
        user-add-pptp
		exit
		;;
		2)
		clear
        echo ""
		echo -e "\e[0;34mSORRY!!! Your ip not support for pptp-vpn use. \e[0;0m"
        echo ""
		exit
		;;
        3)
		clear
        echo ""
		echo -e "\e[0;34mSORRY!!! Your ip not support for pptp-vpn use. \e[0;0m"
        echo ""
		exit
		;;
		4)
		clear
        echo ""
		echo -e "\e[0;34mSORRY!!! Your ip not support for pptp-vpn use. \e[0;0m"
        echo ""
		exit
		;;
        5)
		clear
        echo ""
		exit
        echo ""
		exit
		;;
	esac
done

cd ~/
