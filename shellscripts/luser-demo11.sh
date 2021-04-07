#!/bin/bash

#the script disables,deletes , and/or archives users on the local system.

#make sure the script is running with super user priviliages 

ARCHIVE_DIR='/archive'

usage() {
   # display  the usage and exit.
   echo "Usage: ${0} [-dra] USER [USERN]..." >&2
   echo "disable local linux account.' >&2
   echo ' -d delete accounts instead of disabling them.' >&2
   echo ' -r Removes home directory associated with the accounts.' >&2
   echo ' -a Creates an archive of the home directory associated with the account(s).' >&2
   exit 1
}

if [[ "${UID}" -ne 0 ]]
then 
   echo 'Please  run with sudo or as root .' >&2
   exit 1
fi

#parse the options

while getopts dra OPTION 
do 
 case ${OPTION} in 
   d) DELETE_USER='true' ;;
   r) REMOVE_OPTION='-r' ;;
   a) ARCHIVE='true' ;;
   ?) usage ;;
 esac
done

#removes the options while leaving the remaining arguments 
shift "$(( OPTIND - 1 ))"

#if user does'nt supply atlest one argument , give them help 

if [[ "${#}" -lt 1 ]]
then 
   usage 
fi

#loop through all the usernames supplied as a argumenmts 
for USERNAME in  "${@}"
do 
  echo "Processing under : ${USERNAME}"

  #make sure the UID of the account is atleast 1000
  USERID =$(id -u ${USERNAME})
  if [[ "${USERID}" -lt 1000 ]]
  then 
    echo "Refusing to remove the ${USERNAME} account with user id ${USERID}." >&2
  exit 1
  fi

  #create an archive if requested to do so

  if [[ "${ARCHIVE}" = 'true' ]]
  then 
    #make sure that archive directory exists
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then 
      echo " Creating ${ARCHIVE_DIR} Directory."
      mkdir -p ${ARCHIVE_DIR}
      if [[ "${?}" -ne 0 ]]
      then 
        echo "the archive directory ${ARCHIVE_DIR} couldn't be created." >&2
      exit 1
      fi
    fi

    #Archive the users home directory and move into the archive directory ARCHIVE_DIR
    HOME_DIR="/home/${USERNAME}"
    ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
    if [[ -d "${HOME_DIR}" ]]
    then 
      echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
      tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
      if [[ "${?}" -ne 0 ]]
      then 
        echo "could not create ${ARCHIVE_FILE}." >&2
        exit 1
      fi
    else
      echo "${HOME_DIR} does not exist or is not a directory." >&2
      exit 1
    fi
   fi

  if [[ "${DELETE_USER}" = 'true' ]]
  then 
     #delete the user
     userdel ${REMOVE_OPTION} ${USERNAME}
 
      #check to see if userdel command suceeded or not 
      # we don't want to tell the user that an account was deleted when it hasn't been.
     if [[ "${?}" -ne 0 ]]
     then 
       echo "The account ${USERNAME} was not deleted." >&2
       exit 1
     fi
     echo  "The account ${USERNAME} was deleted."
   else
     chage -E 0 ${USERNAME}
 
     # to check  if the chage command succeded
     # we dont want to tell the user that the account was disabled or when it hasn't been.
     if [[ "${?}" -ne 0 ]]
     then 
       echo  "The account ${USERNAME} was not disabled." >&2
       exit 1
     fi
     echo "The account ${USERNAME} was disabled."
   fi
done


exit 0





