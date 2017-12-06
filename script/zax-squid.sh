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
    echo -e "\e[0;35m                          SQUID (PROXY) OPTIONS\e[0m"
    echo -e "\e[0;34m                         -------ooooOAOooo------\e[0m"
    echo -e "\e[0;35m 1)\e[0m Restart squid3                       (squid3 service restart)"
	echo -e "\e[0;35m 2)\e[0m Change squid3 port                   (change squid3 port)"
    echo -e "\e[0;35m 3)\e[0m Exit                                 (logout)"
    echo ""
	read -p "Select an option from [1-3] than press ENTER: " option1
	case $option1 in
        1)
		clear
        echo -e "\e[0;31mService Squid3 Going Restart NOW.......  \e[0;0m"
		service squid3 restart
        echo ""
		exit
		;;
		2)
		clear
        echo ""
            echo "What squid3 port would you like to change to?"
            read -p "Port: " -e -i 8080 PORT
            sed -i "s/http_port [0-9]*/http_port $PORT/" /etc/squid3/squid.conf
            service squid3 restart
            echo ""
            echo -e "\e[0;36m----------------------------\e[0;0m"
            echo "New Squid3 Allow Port: $PORT"
            echo -e "\e[0;36m----------------------------\e[0;0m" 
            echo -e "\e[0;31mRemember!!! Have to change new proxy port in client config or ssh.\e[0;0m"
            echo ""
		exit
		;;
        3)
		clear
		exit
		exit
		;;
	esac
done

cd ~/