#! /bin/bash

ps -ef | grep pushgateway_current | grep -v grep

if [[ $? -eq 0 ]]; then
exit 0
else
exit 1
fi