#!/bin/bash

USER_ID=${UID}

echo "user id is ${UID}"

USER_ID_TEST='0'

if [[ "${UID}" -eq "${USER_ID_TEST}" ]]
then 
   echo "User id matches"
fi

SAMPLE_USER_ID='10'

if [[ ${UID} -ne ${SAMPLE_USER_ID} ]]

then

   echo "User id didn't matches to root user"

else

   echo "User id matches to root"

fi



USERNAME="$(id -u -n)"

echo "Username is ${USERNAME}"
