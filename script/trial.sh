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


Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c1`
day="1"
Pass=`</dev/urandom tr -dc a-f0-9 | head -c2`

useradd -e `date -d "$day days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "\e[0;36m======= Trial User Created Success =======\e[0;0m"
echo -e ""
echo -e "Username : $Login"
echo -e "Password: $Pass\n"
echo -e "\e[0;36m==========================================\e[0;0m"
echo -e "\e[0;33mThis user will automatic expired 12 hours \e[0;0m"
echo -e ""
cd ~/

