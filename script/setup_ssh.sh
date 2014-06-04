#!/bin/sh

if command -v docker >/dev/null 2>&1; then
  container_ids=`docker ps -q`
  ips=`docker inspect $container_ids | grep IPAddress | cut -d '"' -f 4 | awk 'BEGIN{ORS=","}1'`
fi

export PDSH_SSH_ARGS='-i insecure_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
if command -v pdsh >/dev/null 2>&1; then
  pdsh -R ssh -l root -w $ips /vagrant/script/copy_key.sh
  pdsh -R ssh -l root -w $ips /vagrant/script/add_authorized_keys.sh
fi
