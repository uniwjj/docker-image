#!/bin/bash

sed -i "s/HOSTNAME/$HOSTNAME/" /usr/local/hadoop/etc/hadoop/core-site.xml

/usr/sbin/sshd
/usr/local/hadoop/sbin/start-dfs.sh
/usr/local/hadoop/sbin/start-yarn.sh

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

