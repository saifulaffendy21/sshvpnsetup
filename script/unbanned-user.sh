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
echo ""   
echo -e "\e[0;36m----------- USER LIST ------------\e[0;0m"
echo "USERNAME              EXP DATE     "
while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
# end of user-list   
echo ""   
echo -e "\e[0;34m -------------------- UNLOCK USER ---------------------"
echo -e "\e[0;31m Remember: This funtion working with user was lock only \e[0;0m"
echo ""   
read -p " What username you want to unlock ?:" username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
echo ""
	read -p " Are you sure want to unlock username ($username) [y/n]: " -e -i y UNBANNED
	if [[ "$UNBANNED" = 'y' ]]; then
		#sed -i "s/ User : $username//g" /root/banneduser.txt
		#sed -i /^$/d /root/banneduser.txt
        
		echo ""
echo -e "\e[0;34m ------------------------------------------\e[0;0m"       
		echo -e "\e[0;35m Username ($username) Unlock Success !\e[0;0m"
echo -e "\e[0;34m -------------------------------------------\e[0;0m"
passwd -u $username
echo ""
	else
echo -e "\e[0;34m Canceled unlock this username ($username) !\e[0;0m"
echo ""
	fi
else
	echo -e "\e[0;31m This username ($username) not registed in systems !\e[0;0m"   
    echo ""
	exit 1
fi

cd ~/
