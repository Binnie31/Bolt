#!/bin/bash

hostname=`hostname`
cluster_name=`cat /etc/patroni/*.yml |grep -i scope| cut -d " " -f2-`

replicas=(`patronictl -c /etc/patroni/*.yml list|grep -i replica|awk {'print $4'}`) #hostnames of replicas
replicas_alias=(`patronictl -c /etc/patroni/${ls} list|grep -i replica|awk {'print $2'}`)
leader=`patronictl -c /etc/patroni/${ls} list|grep -i leader|awk {'print $4'}`
leader_alias=`patronictl -c /etc/patroni/${ls} list|grep -i leader|awk {'print $2'}`
 
if [[ $leader == $hostname ]]
then
    echo "switching over"
    patronictl -c /etc/patroni/${ls} switchover --master $leader_alias --candidate ${replicas_alias[0]}  --force
    sleep 15
    echo "stop patroni"
    systemctl stop patroni@${cluster_name}
fi