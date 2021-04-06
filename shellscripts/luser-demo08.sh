#!/bin/bash

#this script demonstrates I/O redirections

#redirects STDOUT to a file 

FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

#redirects STDIN to a program

read LINE < ${FILE}
echo "Line contains: ${LINE}"

#redirects STDOUT to a file, overwritting a file 
head -n3 /etc/passwd > ${FILE}
echo 
echo "contains of ${FILE}:"
cat ${FILE}
