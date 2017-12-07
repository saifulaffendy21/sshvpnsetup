#!/bin/bash
myip=`wget -qO- ifconfig.co`;
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
    echo -e "\e[0;35m                          SSH - DROPBEAR OPTION\e[0m"
    echo -e "\e[0;34m                         -------ooooOAOooo------\e[0m"
	echo -e "\e[0;35m 1)\e[0m Monitoring dropbear                    (dropmon by port)"
    echo -e "\e[0;35m 2)\e[0m Check Login Dropbear                   (user-login)"
    echo -e "\e[0;35m 3)\e[0m Restart dropbear                       (dropbear service restart)"
	echo -e "\e[0;35m 4)\e[0m Change dropbear port                   (change openvpn port)"
    echo -e "\e[0;35m 5)\e[0m Exit                                   (logout)"
    echo ""
	read -p "Select an option from [1-5] than press ENTER: " option1
	case $option1 in
		1)
		clear
		read -p "What dropbear port number you want check?: " PORT
		dropmon $PORT
		exit
		;;
		2)
		clear
        user-login
		exit
		;;
        3)
		clear
        echo -e "\e[0;31mService Dropbear Going Restart NOW.......  \e[0;0m"
		service dropbear restart
        echo ""
		exit
		;;
		4)
		clear
        echo ""
            echo "What Dropbear port would you like to change to?"
            read -p "Port: " -e -i 443 PORT
            sed -i "s/DROPBEAR_PORT=[0-9]*/DROPBEAR_PORT=$PORT/" /etc/default/dropbear
            service dropbear restart
            echo ""
            echo -e "\e[0;36m----------------------------\e[0;0m" 
            echo "New Dropbear Allow Port: $PORT"
            echo -e "\e[0;36m----------------------------\e[0;0m" 
            echo -e "\e[0;31mRemember!!! Have to change new dropbear port in your ssh seting.\e[0;0m"
            echo ""
		exit
		;;
        5)
		clear
		exit
		exit
		;;
	esac
done

cd ~/