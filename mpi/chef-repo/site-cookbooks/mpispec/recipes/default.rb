#
# Cookbook Name:: mpispec
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

src_dir = File.join(node['mpispec']['src_dir'], 'mpispec')
prefix  = node['mpispec']['prefix']

%w{
  libtool
  automake
  autoconf
  binutils-gold
}.each { |pkg| package pkg }

git src_dir do
  repository node['mpispec']['url']
  revision   node['mpispec']['revision']
  action     :sync
end

bash 'install mpispec' do
  cwd src_dir
  code <<-EOH
    aclocal -I config
    libtoolize --force --copy
    automake --add-missing --foreign --copy
    autoconf
    ./configure --prefix=#{prefix}
    make
    make install
  EOH
  creates File.join(prefix, 'bin', 'mpispec')
end
