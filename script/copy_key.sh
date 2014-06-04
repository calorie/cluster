#!/bin/sh

public_key=/vagrant/keys/`hostname`.pub

[ -d /vagrant/keys ] || mkdir /vagrant/keys
if [ ! -f $public_key ]; then
  cp /root/.ssh/id_rsa.pub $public_key
fi
