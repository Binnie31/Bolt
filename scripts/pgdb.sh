#! /bin/bash

set -e
targets=(`cat /root/project/Targets/pgdb_inventory.txt`)

for i in ${targets[@]}
do
    if [[ $i != \#* ]];then
    # bolt  run elasticsearch::reboot -t $i -v
    bolt command run "cat /etc/bt-myname" -t $i
    sleep 5
    fi
done