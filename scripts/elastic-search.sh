#! /bin/bash

# set -e
targets=(`cat Inventory_files/Elastic-search.yaml | grep -i "    name" | grep -v '#' | cut -d " " -f10`)
# for i in ${targets[@]}; do
#     echo "${i}"
# done
for i in ${targets[@]}
do
    if [[ $i != \#* ]];then
    # bolt  run elasticsearch::reboot -t $i -v
    # cd /root/project
    # pwd
    bolt command run "cat /etc/bt-myname" -t $i  
    echo " --------------------"
    sleep 5
    fi
done