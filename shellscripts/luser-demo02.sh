#!/bin/bash

echo "your userId is ${UID}"

USERNAME=$(id -un)

echo "username is ${USERNAME}"

if [[ ${UID} -eq 0 ]]
then 
   echo 'you are root user'
else
   echo 'you are no root user'
fi
