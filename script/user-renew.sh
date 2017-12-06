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


# begin of user-list
echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "USERNAME              EXP DATE     "
echo -e "\e[0;36m-----------------------------------\e[0;0m"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo ""
# end of user-list

read -p "What username you want to renew: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	read -p "How many day you want renew for username ($username): " AKTIF
	
	expiredate=$(chage -l $username | grep "Account expires" | awk -F": " '{print $2}')
	today=$(date -d "$expiredate" +"%Y-%m-%d")
	expire=$(date -d "$today + $AKTIF days" +"%Y-%m-%d")
	chage -E "$expire" $username
	passwd -u $username

	echo ""
	echo -e "\e[0;36m-----------------------------------\e[0;0m"
	echo "User renew details:"
	echo -e "\e[0;36m-----------------------------------\e[0;0m"
	echo -e "\e[0;35mUsername: $username"
	echo  "Expried day: $(date -d "$today + $AKTIF days" +"%d-%m-%Y")"
	echo -e "\e[0;36m-----------------------------------\e[0;0m"
else
	echo -e "\e[0;31mUsername ($username) not registered in this server!\e[0;0m"
	exit 1
fi

cd ~/
rm -f /root/IP
