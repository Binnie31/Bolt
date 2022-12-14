#! /bin/bash

# bolt plan run elasticsearch::reboot -t pmx-dev6-es02 


cd /root/project
bolt plan run elasticsearch::reboot -t pmx-dev6-es02
# bolt command run whoami -t pmx-dev6-es02
echo "Rebooted: $(date)" >> /root/echo.txt



# targets=(`cat elasticsearch_inventory.txt`)

# for i in ${targets[@]}
# do
#     if [[ $i != \#* ]]
#     then
#         echo $i
#     fi
# done




# while read p; do
#      if [[ $p != \#* ]]
#     then
#         echo $p
#     fi 
#     # echo $p
# done < elasticsearch_inventory.txt
