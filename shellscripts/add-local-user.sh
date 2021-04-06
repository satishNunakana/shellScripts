#!/bin/bash

#This script create a new user on the local system.

#you will prompted to enter the username (login) , the person name and the password.

#the username, password , and the host for the account will be displayed.

#make sure the script will be run in super user persmissions

if [["${UID}" -ne 0 ]]
then
   echo "please run with sudo or as root."
   exit 1
fi

#get username (login)

read -p 'Enter the username to create: ' USER_NAME

#get the real name of the user

read -p 'Enter the real  name of the user: ' COMMENT

#get the password

read -p 'Enter the password for the user: ' PASSWORD

#create the account 

useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then 
   echo 'The account could not be created'
   exit 1
fi

#set password 

echo ${PASSWORD} | passwd --stdin ${USER_NAME}


if [[ ${?} -ne 0 ]]
then 
   echo 'Password could not be set'
   exit 1
fi

#Force password change while login 

passwd  -e ${USER_NAME}


echo 'Username:'
echo "${USER_NAME}"

echo 'password'
echo "${PASSWORD}"

echo 'host:'
echo "$HOSTNAME"
