#!/bin/bash

sed -i s/HOSTNAME/$HOSTNAME/g /usr/local/hive/conf/hive-site.xml

# 启动MySQL
service mysqld start
# 启动Hadoop
/etc/bootstrap.sh
# 启动Hive
hiveserver2

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

