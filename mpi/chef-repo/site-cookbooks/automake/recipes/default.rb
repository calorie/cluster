#
# Cookbook Name:: automake
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ark 'automake' do
  owner   node['user']
  url     node['automake']['url']
  version node['automake']['version']
  timeout 36000
  action  :install_with_make
end
