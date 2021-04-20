#!/bin/sh
path="/home/ec2-user/shellscript/files/*"
find ${path} -mtime +1 -exec rm -rf {} \;
