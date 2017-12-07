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
echo ""
echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo ""
# end of user-list

read -p "What username you want change password: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	read -p "Enter new password for ($username): " password
	read -p "Re-enter new password for ($username): " password1
	echo ""
	if [[ $password = $password1 ]]; then
		echo $username:$password | chpasswd
		echo -e "\e[0;36mPassword replaced for ($username) was Success\e[0;0m"
		echo ""
		echo -e "\e[0;36m-----------------------------------\e[0;0m"
		echo "User password change details:"
		echo -e "\e[0;36m-----------------------------------\e[0;0m"
		echo -e "\e[0;35mUsername: $username"
		echo  "Password: $password"
		echo -e "\e[0;36m-----------------------------------\e[0;0m"
	else
		echo -e "\e[0;31mWrong password replace of ($username)\e[0;0m"
		echo -e "\e[0;31mNew password & re-enter new password not same!\e[0;0m"
	fi
else
	echo -e "\e[0;31mThis ($username) not register in server\e[0;0m"
	exit 1
fi

cd ~/
rm -f /root/IP
