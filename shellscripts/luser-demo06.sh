#!/bin/bash

#this script specifies random password for each user specied on the command line

#display what the user typed on the command line

echo "you executed this command ${0}"

#display the path and filename of the script

#echo "You used $(dirname{0}) as the path to the $(basename{0}) script"

NO_OF_PARAMETERS="${#}"

echo "you have supplied ${NO_OF_PARAMETERS} as a argument(s) on the command line"

#make sure they atleast supply one argument

if [[ "${NO_OF_PARAMETERS}" -lt 1 ]]

then 

   echo "Usage: ${0} USER_NAME [USER_NAME]..."
   exit
fi

#generate and display password for each parameter

for USER_NAME in ${@}

do 

  PASSWORD=$(date +%s%N | sha256sum | head -c48)
  echo "${USER_NAME}: ${PASSWORD}"

done
