#
# Cookbook Name:: openmpi
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node['openmpi']['version']
url     = node['openmpi']['url']
dir     = node['openmpi']['dir']
prefix  = node['openmpi']['prefix']

tar    = "openmpi-#{version}.tar.gz"
source = File.join(dir, "openmpi-#{version}")

%w{
  autotools-dev
  autoconf
  automake
  g++
  gfortran
  build-essential
}.each do |pkg|
  package pkg
end

remote_file File.join(dir, tar) do
  source url
  mode '0644'
end

execute 'untar openmpi' do
  command "tar -xzf #{tar}"
  cwd dir
  creates source
end

bash 'install openmpi' do
  cwd source
  code <<-EOH
    ./configure --prefix=#{prefix}
    make
    make install
  EOH
  creates File.join(prefix, 'bin', 'mpicc')
end
