#!/bin/bash

#this script shows open network ports on a system
#use -4 as an argument to limit to tcpv4 ports.

netstat -nutl | grep ':' | awk '{print$4}' | awk -F ':' '{print$NF}'



