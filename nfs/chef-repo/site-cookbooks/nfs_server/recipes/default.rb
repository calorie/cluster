#
# Cookbook Name:: nfs_server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nfs::server'

nfs_dir = node['nfs_server']['dir']

directory nfs_dir

nfs_export nfs_dir do
  network   '*'
  writeable true
  sync      true
  options   ['rw', 'insecure', 'no_root_squash', 'no_subtree_check']
end
