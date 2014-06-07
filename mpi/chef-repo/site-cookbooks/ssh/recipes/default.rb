#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

private_key_path = File.join(node['ssh']['user_home'], '.ssh', 'id_rsa')

execute 'ssh keygen' do
  command "ssh-keygen -f #{private_key_path} -t rsa -N '' > /dev/null"
  creates private_key_path
end

ruby_block 'ssh config' do
  block do
    f = Chef::Util::FileEdit.new('/etc/ssh/ssh_config')
    f.insert_line_if_no_match('/\AStrictHostKeyChecking no\z', 'StrictHostKeyChecking no')
    f.write_file
  end
end