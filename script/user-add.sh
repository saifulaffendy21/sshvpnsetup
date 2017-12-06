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


read -p "Username: " USER

egrep "^$USER" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo -e "\e[0;31mThis username ($USER) already exits!\e[0m"
	exit 1
else
	read -p "Password for username ($USER): " PASS
	read -p "Day active for username ($USER): " AKTIF

	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $USER
	echo $USER:$PASS | chpasswd

	echo ""
	echo -e "\e[0;36m-----------------------------------\e[0m"
	echo "New SSS-VPN user details:"
	echo -e "\e[0;36m-----------------------------------\e[0m"
	echo -e "\e[0;35mUsername: $USER"
	echo "Password: $PASS"
	echo "EXpired: $(date -d "$AKTIF days" +"%d-%m-%Y")"
	echo -e "\e[0;36m-----------------------------------\e[0m"
fi

cd ~/
rm -f /root/ip.txt
