#!/bin/bash

#count the no of faile dlogin attempts 
#if there are any IPs with over LIMIT failures, display the count, IP, and location.

LIMIT ='10'
LOG_FILE="${1}"

#make sure a file was supplid as an argument.

if [[ ! -e "${LOG_FILE}" ]]
then 
  echo "Cannot open log file:${LOG_FILE}" >&2
  exit 1
fi

#loop through the list of failed attempts and the corresponding IP addresses.

grep Failed syslog-sample | awk '{print $( NF -3 )}' | sort | uniq -c | sort -nr | while read COUNT IP

do 
 # if the number of failed login attempts is grater than the limit, display count , IP and location

 if [[ "${COUNT}" -gt "${LIMIT}" ]]
 then 
   LOCATION=$(geoiplookup ${IP})
   echo "${COUNT} ${IP} ${LOCATION}"
 fi
done

exit 0
