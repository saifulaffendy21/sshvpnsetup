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


data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "Checking Dropbear login";
echo -e "\e[0;36m-----------------------------------\e[0;0m"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $USER - $IP";
	fi
done

echo "";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "Checking OpenSSH login";
echo -e "\e[0;36m-----------------------------------\e[0;0m"
for PID in "${data[@]}"
do
        #echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
	IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo "$PID - $USER - $IP";
        fi
done

echo "";

echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "Checking OpenVPN login";
echo -e "\e[0;36m-----------------------------------\e[0;0m"
tail -f /etc/openvpn/openvpn-status.log

echo "";

echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "Checking PPTP login";
echo -e "\e[0;36m-----------------------------------\e[0;0m"
last | grep ppp | grep still

echo "";


echo -e "\e[0;36m-----------------------------------\e[0;0m"
echo "Checking PPTP Login History";
echo -e "\e[0;36m-----------------------------------\e[0;0m"
last | grep ppp

echo "";
echo -e "\e[0;36m-----------------------------------\e[0;0m" 
echo " Thank you for using my script "
echo " http://leedzung-autoscript.net "
echo "       Tel: +60146463183"
echo -e "\e[0;36m-----------------------------------\e[0;0m" 
echo ""

cd ~/
rm -f /root/IP
