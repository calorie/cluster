#!/bin/sh

keys_dir=/data/keys
keys=${keys_dir}/*.pub
authorized_keys=/root/.ssh/authorized_keys

if [ -f $authorized_keys ]; then
  rm -f $authorized_keys
  cat /etc/insecure_key.pub > $authorized_keys
  chmod 600 $authorized_keys
fi

if ls $keys &> /dev/null; then
  cat $keys >> $authorized_keys
fi
