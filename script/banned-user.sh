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


# begin of user-list
echo -e "\e[0;36m----------- USER LIST ------------\e[0;0m"
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
echo -e "\e[0;31m Warning !!!  User will be block...\e[0;0m"
echo ""
read -p " What username you want Lock ?: " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p " Are you sure want to lock username ($username) [y/n]: " -e -i y BANNED
	if [[ "$BANNED" = 'y' ]]; then
echo ""		
echo -e "\e[0;32m----------------------------------------------------\e[0;0m"
echo -e "\e[0;33m Username ($username) is Locked .\e[0;0m"
echo -e "\e[0;32m----------------------------------------------------\e[0;0m"   
passwd -l $username
    echo ""
	else
    echo ""
		echo -e "\e[0;33m Username ($username) was canceled !\e[0;0m"
    echo ""
	fi
else
    echo ""
echo -e "\e[0;31m Username ($username) not register in systems !\e[0;0m"
    echo ""
	exit 1
fi

cd ~/
