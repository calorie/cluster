#
# Cookbook Name:: mpispec
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

repo   = File.join(node['mpispec']['dir'], 'mpispec')
prefix = node['mpispec']['prefix']

git repo do
  repogitory node['mpispec']['url']
  revision   node['mpispec']['revision']
  action     :sync
end

bash 'install mpispec' do
  cwd repo
  code <<-EOH
    ./configure --prefix=#{prefix}
    make
    make install
  EOH
  creates File.join(prefix, 'bin', 'mpispec')
end