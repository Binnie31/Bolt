#! /bin/bash

set -e
targets=(`cat Inventory_files/core.yaml | grep -i "    name" | grep -v '#' | cut -d " " -f10`)

for i in ${targets[@]}
do
    if [[ $i != \#* ]];then
    # bolt  run elasticsearch::reboot -t $i -v
    bolt command run "cat /etc/bt-myname" -t $i
    sleep 5
    fi
done