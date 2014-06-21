#
# Cookbook Name:: openmpi
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{
  autotools-dev
  autoconf
  automake
  g++
  gfortran
  build-essential
  flex
}.each do |pkg|
  package pkg
end

ark 'openmpi' do
  owner   node['user']
  url     node['openmpi']['url']
  version node['openmpi']['version']
  timeout 36000
  action  :install_with_make
end
