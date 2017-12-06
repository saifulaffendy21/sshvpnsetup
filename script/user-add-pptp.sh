#!/bin/bash
myip=`curl ifconfig.me`;
#myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
flag=0

read -p "New Username: " USER
read -p "Password for ($USER): " PASS

echo "$USER pptpd $PASS *" >> /etc/ppp/chap-secrets

echo ""
echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "Login PPTP VPN details:"
echo -e "\e[0;36m-----------------------------------\e[0;0m" 
echo "Username: $USER"
echo "Password: $PASS"
echo -e "\e[0;36m-----------------------------------\e[0;0m"
cd ~/
cat /dev/null > ~/.bash_history && history -c
