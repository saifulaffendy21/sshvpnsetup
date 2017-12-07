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
#This script installs mysql (latest build)
#Install MYSQL Server
mysql_pass=r0otP4$$
mysql -uroot -p$mysql_pass -e "CREATE DATABASE OCS_PANEL;"
export DEBIAN_FRONTEND=noninteractive 
debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password password '$mysql_pass''
debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password_again password '$mysql_pass''
mysql -uroot -p$mysql_pass -e "CREATE DATABASE OCS_PANEL;"
apt-get -y install mysql-server
#Configure Password and Settings for Remote Access
cp /etc/mysql/my.cnf /etc/mysql/my.bak.cnf
ip=`ifconfig eth0 | grep "inet addr"| cut -d ":" -f2 | cut -d " " -f1` ; sed -i "s/\(bind-address[\t ]*\)=.*/\1= $ip/" /etc/mysql/my.cnf
mysql -uroot -e "UPDATE mysql.user SET Password=PASSWORD('"$mysql_pass"') WHERE User='root'; FLUSH PRIVILEGES;"
sleep 10
mysql -uroot -p$mysql_pass -e "CREATE DATABASE OCS_PANEL;"
mysql -uroot -p$mysql_pass -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '"$mysql_pass"'; FLUSH PRIVILEGES;"
#Restart
service mysql restart
echo "MySQL Installation and Configuration is Complete."

clear
#rip
cd
rm mysql.sh

rm -rf ~/.bash_history && history -c
clear