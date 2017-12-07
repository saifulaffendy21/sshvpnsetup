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
    echo -e "\e[0;35m                         OPENVPN SERVICES OPTION\e[0m"
    echo -e "\e[0;34m                         -------ooooOAOooo------\e[0m"
	echo -e "\e[0;35m 1)\e[0m Download client                          (download client config)"
    echo -e "\e[0;35m 2)\e[0m Download bug                             (download bug openvpn)"
    echo -e "\e[0;35m 3)\e[0m Restart openvpn                          (openvpn service restart)"
	echo -e "\e[0;35m 4)\e[0m Change openvpn port                      (change openvpn port)"
    echo -e "\e[0;35m 5)\e[0m Exit                                     (logout)"
    echo ""
	read -p "Select an option from [1-5] than press ENTER: " option1
	case $option1 in
		1)
		clear
        echo -e "\e[0;36m---------------------------------------\e[0;0m" 
        echo "Download your Openvpn client config by "
        echo -e "\e[0;36m---------------------------------------\e[0;0m" 
        echo ""
        echo -e "\e[0;33m  http://$MYIP$myip/client.ovpn\e[0;0m"
		echo -e "\e[0;33m  Type Your IP/client.ovpn\e[0;0m"
		echo -e "\e[0;33m  Ex: xxx.xxx.xxx.xxx/client.ovpn\e[0;0m"
        echo ""
		exit
		;;
		2)
		clear
        echo ""
		echo -e "\e[0;34m Haven't bug on server \e[0;0m"
        echo ""
		exit
		;;
        3)
		clear
        echo -e "\e[0;31mOpenvpn service going to restart NOW.......  \e[0;0m"
        service openvpn restart
        echo ""
		exit
		;;
		4)
		clear
        echo ""
        
		echo "What Openvpn port would you like to change?"
            read -p "Port: " -e -i 1194 PORT
            sed -i "s/port [0-9]*/port $PORT/" /etc/openvpn/server.conf
            service openvpn restart
            echo ""
            echo -e "\e[0;36m----------------------------\e[0;0m" 
            echo "New Openvpn Allow Port: $PORT"
            echo -e "\e[0;36m----------------------------\e[0;0m" 
            echo -e "\e[0;31mRemember!!! Have to change new openvpn port in your client config \e[0;0m"
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
