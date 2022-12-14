#! /bin/bash

uri="10.226.64.179:8008"
# L = `curl -s -i -X OPTIONS http://us01vlpmxpgdb56.saas-n.com:8008/leader`
# l=`curl -s -i -X OPTIONS http://${uri}.saas-n.com:8008/leader | awk '{print $2}'`
l=`curl -s -i -X OPTIONS http://${uri}/leader | awk '{print $2}'`

echo "$l"

if [[ $l == 200 ]]
then
  echo "inside leader"
#   r=`curl -s -i -X OPTIONS http://us01vlpmxpgdb57.saas-n.com:8008/replica?lag=0 | awk '{print $2}'`
#   if [[ $r == 200 ]]
#     then
#      echo "no lag"
#     else
#     echo "there is lag"
    
#     fi
   curl -s -i -X POST http://us01vlpmxpgdb57.saas-n.com:8008/reinitialize
   curl -s -i -X POST http://us01vlpmxpgdb58.saas-n.com:8008/reinitialize
    

    
else
  echo "bdsk"

fi