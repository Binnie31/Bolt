#!/bin/bash


url=("10.226.64.179" "10.226.64.183" "10.226.64.180")
url1=()
for n in "${url[@]}"
do
    l=`curl -s -i -X OPTIONS http://${n}:8008/leader | awk '{print $2}'`
    if [[ $l -ne 200 ]]
      then
        url1+=(${n})
        
    else 
        echo $n
    fi
done    

for i in "${url1[@]}"
do
    lag=`curl -s -i -X OPTIONS http://${i}:8008/replica?lag=0|awk '{print $2}'`
    echo $lag
    if [[ $lag -eq 200 ]]
    then
        echo "there is no lag"
        COUNT=$((COUNT+1))
    else
        echo "there is lag in ${i}"
        echo " stop the process"
        exit 1
    
    fi
done

echo $COUNT

for n in "${url[@]}"
do
    m=`curl -s -i -X OPTIONS http://${n}:8008/leader | awk '{print $2}'`
    if [[ $m -eq 200 && $COUNT -eq 2 ]]
      then
       
        echo "Continue the process"
    fi
done 