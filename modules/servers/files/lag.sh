#!/bin/bash

patronictl -c /etc/patroni/${ls} list
replicas=(`patronictl -c /etc/patroni/${ls} list|grep -i replica|awk {'print $4'}`)
leader=`patronictl -c /etc/patroni/${ls} list|grep -i leader|awk {'print $4'}`
lag=(`patronictl -c /etc/patroni/${ls} list|grep -i replica|awk {'print $12'}`)

count=0
for i in ${lag[@]}
do
  if [[ $i == 0 ]]
  then
   echo "There is lag in replica"
   echo "reinitializing ${replicas[$count]}"
   curl -s -i -X POST http://${replicas[$count]}:8008/reinitialize
  else
    echo "no lag"  
  fi
  count=$((count+1))  

done  