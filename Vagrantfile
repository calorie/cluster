# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = :latest

  config.vm.define 'mpi' do |v|
    v.vm.provider 'docker' do |d|
      d.name = 'mpi'
      d.build_dir = 'mpi'
    end
  end

  config.vm.define 'mpi_client' do |v|
    v.vm.provider 'docker' do |d|
      d.name = 'mpi_client'
      d.has_ssh = true
      d.build_dir = 'mpi_client'
      # d.link 'mpi:mpi'
    end
    v.ssh.port = 22
    v.ssh.username = 'root'
    v.ssh.private_key_path = 'insecure_key'
  end
end
