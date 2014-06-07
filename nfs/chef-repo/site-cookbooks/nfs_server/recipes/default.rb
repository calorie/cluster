#
# Cookbook Name:: nfs_server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nfs::server'

mount_dir = node['nfs']['mount_dir']

directory mount_dir

nfs_export mount_dir do
  network   '*'
  writeable true
  sync      true
  options   ['rw', 'insecure', 'no_root_squash', 'no_subtree_check']
end
