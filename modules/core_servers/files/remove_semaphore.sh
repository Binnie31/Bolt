#! /bin/bash

env=$( cd /paymodeNFS; echo * | awk '{print $1}')
rm /paymodeNFS/$env/ftp/hold/semaphore/$(cat /etc/bt-myname) -f