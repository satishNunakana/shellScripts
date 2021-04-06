#!/bin/bash

#ask for the username

read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name 

read -p 'Enter the name of the person who is creating the account: ' COMMENT

#Ask for the password 

read -p 'Enter the password to create a user: ' PASSWORD

#Create user

useradd -c "${COMMENT}" -m ${USER_NAME}

#set the password for user

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

#force password chnage

passwd -e ${USER_NAME}
