#!/bin/sh
file=abc.txt
#Logfile=$HOME/ec2-user/log.`date"+%y%m%d%H%M%Z"`.txt
echo "`date`"
echo "User id is ${UID}"
echo "User name is ${USER}"
echo "Hostname is ${HOSTNAME}"
shost="www.google.com"
ping ${shost} -c1 &> /dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS ping ${shost}"
else
	echo "ERROR ping ${shost}"
fi
nslookup ${shost} &> /dev/null
if [ $? -eq 0 ]; then
        echo "SUCCESS nslookup ${shost}"
else
        echo "ERROR nslookup ${shost}"
fi

host=$(hostname) 
ip=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | cut -c 7-17)
echo "IP address is: ${host} -- ${ip}"
#PORT=8080
#a=$(netstat -plnt | grep $PORT | awk '{print $6}')
#echo $a;exit
#while [ "$a" != "LISTEN" ]
#do
# (( PORT=PORT+1 ))
#printf "Port number is $PORT\n"
#done
