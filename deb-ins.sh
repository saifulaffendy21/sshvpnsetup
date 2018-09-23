#!/bin/bash
myip=`wget -qO- ifconfig.co`;
#myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
flag=0
if [ $USER != 'root' ]; then
	echo "Sorry, for run the script please using root user"
	exit
fi


apt-get update
apt-get --assume-yes install libxml-parser-perl
apt-get --assume-yes install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt

wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/mysql.sh
chmod +x mysql.sh
./mysql.sh
clear

wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/mysql_secure.sh
chmod +x mysql_secure.sh
./mysql_secure.sh
clear
useradd -m vps
mkdir -p /home/vps/public_html
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/nginx.conf
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php

wget -O /etc/nginx/conf.d/vps.conf https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/vps.conf
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
service php5-fpm restart
service nginx restart
clear
apt-get -y install zip unzip
cd /home/vps/public_html

wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/LeepanelV1.zip
unzip LeepanelV1.zip
rm -f LeepanelV1.zip
clear
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
clear
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
php5enmod mcrypt
rm -r /root/ocs
clear
cd
rm .sh
rm mysql.sh
rm mysql_secure.sh
rm -rf ~/.bash_history && history -c
clear
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/dotdeb.gpg
wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/jcameron-key.asc
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
clear
apt-get update;apt-get -y upgrade;apt-get -y install wget curl
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to *** ***** (pancake-23092018) Autoscript'
apt-get -y install squid3

wget -O /etc/squid3/squid.conf https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/squid.conf
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
apt-get -y install openvpn
cd /etc/openvpn/

wget https://github.com/asyraaf92/sshvpnsetup/raw/dev/zip/openvpn.tar;tar xf openvpn.tar;rm openvpn.tar

wget -O /etc/iptables.up.rules https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/iptables.up.rules
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules

wget -O /home/vps/public_html/client.ovpn https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/client.ovpn
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn;cd

wget https://github.com/asyraaf92/sshvpnsetup/raw/dev/zip/cronjob.tar
tar xf cronjob.tar;mv uptimes.php /home/vps/public_html/
mv usertol userssh uservpn /usr/bin/;mv cronvpn cronssh /etc/cron.d/
chmod +x /usr/bin/usertol;chmod +x /usr/bin/userssh;chmod +x /usr/bin/uservpn;
useradd -m -g users -s /bin/bash sshvpn
echo "sshvpn:123456" | chpasswd
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart
apt-get -y install fail2ban;
service fail2ban restart

wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/webmin.sh
chmod +x webmin.sh
./webmin.sh

wget https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/pptp.sh
chmod +x pptp.sh
./pptp.sh

#adding menu with wget 23-09-2018
wget -O /usr/bin/menu https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/menu.sh

wget -O /usr/bin/user-add https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-add.sh

wget -O /usr/bin/user-renew https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-renew.sh

wget -O /usr/bin/user-pass https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-pass.sh

wget -O /usr/bin/user-del https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-del.sh

wget -O /usr/bin/user-list https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-list.sh

wget -O /usr/bin/user-expire https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-expire.sh

wget -O /usr/bin/user-gen https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-gen.sh

wget -O /usr/bin/user-add-pptp https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-add-pptp.sh

wget -O /usr/bin/dropmon https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/dropmon.sh

wget -O /usr/bin/user-login https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-login.sh

wget -O /usr/bin/user-limit https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-limit.sh

wget -O /usr/bin/ps-mem https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/ps_mem.py

wget -O /usr/bin/speedtest https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/speedtest_cli.py

wget -O /usr/bin/benchmark https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/benchmark.sh

wget -O /usr/bin/trial https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/trial.sh

wget -O /usr/bin/zax-pptp https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/zax-pptp.sh

wget -O /usr/bin/zax-script https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/zax-script.sh

wget -O /usr/bin/zax-openvpn https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/zax-openvpn.sh

wget -O /usr/bin/zax-webmin https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/zax-webmin.sh

wget -O /usr/bin/zax-ssh https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/zax-ssh.sh

wget -O /usr/bin/zax-squid https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/zax-squid.sh

wget -O /usr/bin/banned-user https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/banned-user.sh

wget -O /usr/bin/unbanned-user https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/unbanned-user.sh

wget -O /usr/bin/autokill https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/autokill.sh

wget -O /usr/bin/user-data https://raw.githubusercontent.com/asyraaf92/sshvpnsetup/dev/script/user-data.sh

clear
chmod +x /usr/bin/menu
chmod +x /usr/bin/user-add
chmod +x /usr/bin/user-renew
chmod +x /usr/bin/user-pass
chmod +x /usr/bin/user-del
chmod +x /usr/bin/user-list
chmod +x /usr/bin/user-expire
chmod +x /usr/bin/user-gen
chmod +x /usr/bin/user-add-pptp
chmod +x /usr/bin/dropmon
chmod +x /usr/bin/user-login
chmod +x /usr/bin/user-limit
chmod +x /usr/bin/ps-mem
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/benchmark
chmod +x /usr/bin/trial
chmod +x /usr/bin/zax-openvpn
chmod +x /usr/bin/zax-webmin
chmod +x /usr/bin/zax-ssh
chmod +x /usr/bin/zax-squid
chmod +x /usr/bin/zax-pptp
chmod +x /usr/bin/banned-user
chmod +x /usr/bin/unbanned-user
chmod +x /usr/bin/autokill
chmod +x /usr/bin/user-data
echo "0 0 * * * root /usr/bin/user-expire" > /etc/cron.d/user-expire
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "* * * * * service dropbear restart" > /etc/cron.d/dropbear
rm $0
clear
service openvpn restart
service squid3 restart
service ssh restart
service dropbear restart
service nginx start
cat /dev/null > ~/.bash_history && history -c
clear
