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
    echo -e "\e[0;35m                         WEBMIN SERVICES OPTIONS\e[0m"
    echo -e "\e[0;34m                         -------ooooOAOooo------\e[0m"
	echo -e "\e[0;35m 1)\e[0m Root password change                     (webmin password change)"
    echo -e "\e[0;35m 2)\e[0m Restart systems                          (vps reboot)"
	echo -e "\e[0;35m 3)\e[0m Memory Usage                             (ram-usage)"
	echo -e "\e[0;35m 4)\e[0m Speedtest                                (speedtest)"
	echo -e "\e[0;35m 5)\e[0m Benchmark                                (benchmark)"
    echo -e "\e[0;35m 6)\e[0m Exit                                     (logout)"
    echo ""
	read -p "Select an option from [1-6] than press ENTER: " option1
	case $option1 in
        1)
		clear
        passwd
		exit
		;;
        2)
		clear
        echo -e "\e[0;31m The system going to reboot NOW.......  \e[0;0m"
        reboot
		exit
		;;
		3)
		clear
		ps-mem
		exit
		;;
		4)
		clear
		speedtest
		exit
		;;
		5)
		clear
		benchmark
		exit
		;;
        6)
		clear
		exit
		exit
		;;
	esac
done

cd ~/
