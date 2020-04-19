#!/bin/bash

sed -i s/HOSTNAME/$HOSTNAME/g /usr/local/hive/conf/hive-site.xml

# start mysql
service mysqld start
# start hadoop
/root/hadoop-start.sh
# start hive server
hiveserver2

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

