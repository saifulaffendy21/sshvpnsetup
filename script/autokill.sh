#!/bin/bash

x=$1
case $x in
0)
	#dropbear
	rm -f /root/dropbearport
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo "Dropbear Port:"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		echo "$line ==> Limit $x login"
		#grep "iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local > /dev/null
		#if [[ $? != 0 ]];then
			#sed -i "1 a\iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local
		#fi
		#sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/g" -i /etc/rc.local
	done
	
	echo ""
	rm -f /root/dropbearport
	
	#openssh
	rm -f /root/opensshport
	opensshport="$(netstat -nlpt | grep -i sshd | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo "OpenSSH Port:"
	
	cat > /root/opensshport <<-END
	$opensshport
	END
	
	exec</root/opensshport
	while read line
	do
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		echo "$line ==> Limit $x login"
		#grep "iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local > /dev/null
		#if [[ $? != 0 ]];then
			#sed -i "1 a\iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local
		#fi
		#sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/g" -i /etc/rc.local
	done
	
	echo ""
	rm -f /root/opensshport
	
	sed '/^$/d' /etc/rc.local > /tmp/rc.local
	cat /tmp/rc.local > /etc/rc.local
	/etc/rc.local start
;;
2)
	#dropbear
	rm -f /root/dropbearport
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo "Dropbear Port:"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		echo "$line ==> Limit $x login"
		grep "iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local > /dev/null
		if [[ $? != 0 ]];then
			sed -i "1 a\iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local
		fi
		#sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/g" -i /etc/rc.local
	done
	
	echo ""
	rm -f /root/dropbearport
	
	#openssh
	rm -f /root/opensshport
	opensshport="$(netstat -nlpt | grep -i sshd | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo "OpenSSH Port:"
	
	cat > /root/opensshport <<-END
	$opensshport
	END
	
	exec</root/opensshport
	while read line
	do
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		echo "$line ==> Limit $x login"
		grep "iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local > /dev/null
		if [[ $? != 0 ]];then
			sed -i "1 a\iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local
		fi
		#sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/g" -i /etc/rc.local
	done
	
	echo ""
	rm -f /root/opensshport
	
	sed '/^$/d' /etc/rc.local > /tmp/rc.local
	cat /tmp/rc.local > /etc/rc.local
	/etc/rc.local start
;;
3)
	#dropbear
	rm -f /root/dropbearport
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo "Dropbear Port:"

	cat > /root/dropbearport <<-END
	$dropbearport
	END

	exec</root/dropbearport
	while read line
	do
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		echo "$line ==> Limit $x login"
		grep "iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local > /dev/null
		if [[ $? != 0 ]];then
			sed -i "1 a\iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local
		fi
		#sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/g" -i /etc/rc.local
	done
	
	echo ""
	rm -f /root/dropbearport
	
	#openssh
	rm -f /root/opensshport
	opensshport="$(netstat -nlpt | grep -i sshd | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	echo "OpenSSH Port:"
	
	cat > /root/opensshport <<-END
	$opensshport
	END
	
	exec</root/opensshport
	while read line
	do
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 2 -j REJECT//g" -i /etc/rc.local
		sed "s/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above 3 -j REJECT//g" -i /etc/rc.local
		echo "$line ==> Limit $x login"
		grep "iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local > /dev/null
		if [[ $? != 0 ]];then
			sed -i "1 a\iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT" /etc/rc.local
		fi
		#sed "s/#iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/iptables -A INPUT -p tcp --syn --dport $line -m connlimit --connlimit-above $x -j REJECT/g" -i /etc/rc.local
	done
	
	echo ""
	rm -f /root/opensshport
	
	sed '/^$/d' /etc/rc.local > /tmp/rc.local
	cat /tmp/rc.local > /etc/rc.local
	/etc/rc.local start
;;
*)
   echo ""          
   echo -e "\e[0;36m----------- Please, run command to get the action ------------\e[0;0m" 
    echo ""         
	echo -e "\e[0;0mType command\e[0;0m \e[0;31mautokill 0\e[0;0m \e[0;0mfor unlimited user login\e[0;0m"
	echo -e "\e[0;0mType command\e[0;0m \e[0;31mautokill 1\e[0;0m \e[0;0mfor 1 user login only\e[0;0m"
	echo -e "\e[0;0mType command\e[0;0m \e[0;31mautokill 2\e[0;0m \e[0;0mfor 2 user login maximum\e[0;0m"
    echo -e "\e[0;0mType command\e[0;0m \e[0;31mautokill 3\e[0;0m \e[0;0mfor 3 user login maximum\e[0;0m"
	echo ""
;;
esac

cd ~/
