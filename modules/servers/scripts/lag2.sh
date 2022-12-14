#! /bin/bash
uri="10.226.64.179"


l=`curl -s -i -X OPTIONS http://${uri}:8008/leader | awk '{print $2}'`

if [[ $l == 200 ]]
then
  echo "inside leader"
  curl -s -i -X POST http://us01vlpmxpgdb57.saas-n.com:8008/reinitialize
  curl -s -i -X POST http://us01vlpmxpgdb58.saas-n.com:8008/reinitialize
else
  echo "reinitializing"
  curl -s -i -X POST http://${uri}:8008/reinitialize
fi