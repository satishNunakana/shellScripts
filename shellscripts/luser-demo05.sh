#!/bin/bash

#this script generates list of random passwords

# a random number as apassword

PASSWORD="${RANDOM}"

echo ${PASSWORD}

#three random numbers together

PASSWORD="${RANDOM}${RANDOM}${RANDOM}"

echo ${PASSWORD}

#use current date and time as a password basis

PASSWORD=$(date +%s)

echo "${PASSWORD}"

#use nanoseconds to act as a randomization

PASSWORD=$(date +%s%N)

echo "${PASSWORD}"

#for better random passowrd

PASSWORD=$(date +%s%N | sha256sum | head -c8)

echo "${PASSWORD}"

#adding special characters to password

SPECIAL_CHARACTERS=$(echo '!@#$%^&*()_+{}[]\<>/' | fold  -w1 | shuf | head -c1)

echo "${SPECIAL_CHARACTERS}"

