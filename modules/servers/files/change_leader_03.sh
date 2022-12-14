#!/bin/bash



hostname=`hostname`
cluster_name=`cat /etc/patroni/*.yml |grep -i scope| cut -d " " -f2-`
 
# patronictl -c /etc/patroni/${ls} list
replicas=(`patronictl -c /etc/patroni/*.yml list|grep -i replica|awk {'print $4'}`) #hostnames of replicas
replicas_alias=(`patronictl -c /etc/patroni/${ls} list|grep -i replica|awk {'print $2'}`)
leader=`patronictl -c /etc/patroni/${ls} list|grep -i leader|awk {'print $4'}`
lag=(`patronictl -c /etc/patroni/${ls} list|grep -i replica|awk {'print $12'}`)
leader_alias=`patronictl -c /etc/patroni/${ls} list|grep -i leader|awk {'print $2'}`
 
if [[ $leader == $hostname ]]
then 
    echo "checking lag in pgdb03"
    if [[ ${lag[1]} != 0 ]]
    then 
        echo "reinitializing"
        curl -s -i -X POST http://${replicas[1]}:8008/reinitialize| grep -i reinit
        sleep 15
    fi    
    echo "switching over to pgdb03"
    patronictl -c /etc/patroni/${ls} switchover --master $leader_alias --candidate ${replicas_alias[1]}  --force
    sleep 15
    echo "stopping patroni service of ${hostname}"
    systemctl stop patroni@${cluster_name}
else
    echo "${hostname} is a replica. Stopping patroni service"
    systemctl stop patroni@${cluster_name}
    #systemctl status patroni@${cluster_name}
fi  


# patronictl -c /etc/patroni/pmx-dev99.yml switchover --master us01vlpmxpgdb57.saas-n.com --candidate us01vlpmxpgdb56.saas-n.com --force