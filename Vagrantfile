# -*- mode: ruby -*-
# vi: set ft=ruby :

system '. ./script/bootstrap'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define 'mpi' do |v|
    v.vm.provider 'docker' do |d|
      d.name = 'mpi'
      d.build_dir = 'mpi'
      d.has_ssh = true
    end
    v.ssh.port = 22
    v.ssh.username = 'root'
    v.ssh.private_key_path = 'insecure_key'
  end

  config.vm.define 'mpi_client' do |v|
    v.vm.provider 'docker' do |d|
      d.name = 'mpi_client'
      d.build_dir = 'mpi_client'
      d.has_ssh = true
      # d.link 'mpi:mpi'
    end
    v.ssh.port = 22
    v.ssh.username = 'root'
    v.ssh.private_key_path = 'insecure_key'
  end

  # config.vm.provision :shell, path: File.join('script', 'copy_key.sh')
  # config.vm.provision :shell, path: File.join('script', 'add_authorized_keys.sh')

  # if Vagrant.has_plugin?('vagrant-triggers')
  #   config.trigger.after :up, stdout: true do
  #     info 'Set up network'
  #     run  './script/setup_ssh.sh'
  #   end
  # end
end
