#
# Cookbook Name:: nfs_client
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nfs'

nfs_dir = node['nfs_client']['dir']
nfs_server_ip = node['nfs_client']['server_ip']

directory nfs_dir

# mount nfs_dir do
#   device  "#{nfs_server_ip}:#{nfs_dir}"
#   fstype  'nfs'
#   options 'rw,proto=tcp,port=2049'
#   action  [:mount, :enable]
# end
