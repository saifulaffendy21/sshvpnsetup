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


if [ $1 ];then
port_dropbear=$1
log=/var/log/auth.log
loginsukses='Password auth succeeded'
echo ' '
echo ' '
echo "               Dropbear Users Login Monitor "
echo "---------------------------------------------------------------"
echo "  Date-time    |  PID      |  User Name      |  From Host " 
echo "---------------------------------------------------------------" 
pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
for pid in $pids 
do
    pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
    i=0
    for pidend in $pidlogs
    do
      let i=i+1
    done   
    if [ $pidend ];then
       login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
       PID=$pid
       user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
       waktu=`echo $login |awk -F" " '{print $2,$3}'`
       while [ ${#waktu} -lt 13 ]
       do
           waktu=$waktu" " 
       done

       while [ ${#user} -lt 16 ]
       do
           user=$user" " 
       done
       while [ ${#PID} -lt 8 ]
       do
           PID=$PID" " 
       done

       fromip=`echo $login |awk -F" " '{print $12}' |awk -F":" '{print $1}'`
       echo "  $waktu|  $PID | $user|  $fromip "
    fi
done
echo "----------------------------------------------------------------" 
echo " Want to kick user? Type kill -9 (PID numbers)"
echo " Example: kill -9 1234 [enter]"
else
echo "  Use the command ./dropmon [port]"
echo "  Example : ./dropmon 443"
echo ""
fi
exit 0

cd ~/
rm -f /root/IP
