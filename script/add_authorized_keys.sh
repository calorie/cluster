#!/bin/sh

authorized_keys=/root/.ssh/authorized_keys

if [ ! -f $authorized_keys ]; then
  touch $authorized_keys
  chmod 600 $authorized_keys
fi

if ls /vagrant/keys/*.pub &> /dev/null; then
  cat /vagrant/keys/*.pub >> $authorized_keys
fi
