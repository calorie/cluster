#!/bin/sh

nfs_server='192.168.33.10'
mount_dir=/data
keys_dir=${mount_dir}/keys
public_key=${keys_dir}/`hostname`.pub

[ -d $keys_dir ] || mkdir $keys_dir

if ! mountpoint -q $mount_dir ; then
  mount -t nfs -o rw,proto=tcp,port=2049 ${nfs_server}:${mount_dir} $mount_dir
fi

if [ ! -f $public_key ]; then
  cp /root/.ssh/id_rsa.pub $public_key
fi
