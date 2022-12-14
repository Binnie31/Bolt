#!/bin/bash
 
flag=`ps -ef|grep "log-level-file"|grep -v grep|wc -l`
 
if [[ $flag != "0" ]]
then
    echo " Some Backup Are Running On backrest"
    exit 1
fi  