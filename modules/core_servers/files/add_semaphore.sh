#! /bin/bash

env=$( cd /paymodeNFS; echo * | awk '{print $1}')
echo "This file is created by bolt on $(date) for rebooting $(cat /etc/bt-myname)" > /paymodeNFS/$env/ftp/hold/semaphore/$(cat /etc/bt-myname)

