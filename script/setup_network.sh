#!/bin/sh

container_home='/root'

if command -v docker >/dev/null 2>&1; then
  container_ids=`docker ps | grep -v 'nfs\|CONTAINER' | awk '{print $1}'`
  if [ -n "${container_ids}" ]; then
    ips=`docker inspect $container_ids | grep IPAddress | cut -d '"' -f 4 | awk 'BEGIN{ORS=","}1'`
  fi
fi

if command -v pdsh >/dev/null 2>&1 && [ -n "${ips}" ]; then
  export PDSH_SSH_ARGS='-i insecure_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
  pdsh -R ssh -l root -w $ips ${container_home}/copy_key.sh
  pdsh -R ssh -l root -w $ips ${container_home}/add_authorized_keys.sh
fi
