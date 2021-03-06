# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define 'nfs' do |v|
    v.vm.box          = 'ubuntu'
    v.vm.box_url      = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box'
    v.vm.boot_timeout = 1000
    v.vm.network :private_network, ip: '192.168.33.10'
    v.vm.provider 'virtualbox' do |vb|
      vb.name   = 'nfs'
      vb.memory = 1024
    end
    v.vm.provision :chef_solo do |chef|
      repo                = File.join('nfs', 'chef-repo')
      chef.cookbooks_path = [File.join(repo, 'cookbooks'), File.join(repo, 'site-cookbooks')]
      chef.roles_path     = File.join(repo, 'roles')
      chef.data_bags_path = File.join(repo, 'data_bags')
      chef.json           = JSON.parse(Pathname(__FILE__).dirname.join(repo, 'nodes', 'nfs.json').read)
      chef.add_role 'nfs'
    end
  end

  config.vm.define 'mpi0' do |v|
    v.vm.hostname = 'mpi0'
    v.vm.provider 'docker' do |d|
      d.name        = 'mpi0'
      d.build_dir   = 'mpi'
      d.build_args  = ['--tag=local/mpi0']
      d.create_args = ['--privileged']
      d.has_ssh     = true
    end
    v.ssh.port             = 22
    v.ssh.username         = 'root'
    v.ssh.private_key_path = 'insecure_key'
  end
  config.vm.define 'mpi1' do |v|
    v.vm.hostname = 'mpi1'
    v.vm.provider 'docker' do |d|
      d.name        = 'mpi1'
      d.build_dir   = 'mpi'
      d.build_args  = ['--tag=local/mpi1']
      d.create_args = ['--privileged']
      d.has_ssh     = true
    end
    v.ssh.port             = 22
    v.ssh.username         = 'root'
    v.ssh.private_key_path = 'insecure_key'
  end

  # if Vagrant.has_plugin?('vagrant-triggers')
  #   config.trigger.after :up, stdout: true do
  #     info 'Set up network'
  #     run  './script/setup_network.sh'
  #   end
  # end
end
