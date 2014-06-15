require 'json'

class Upper
  def initialize(config, options = {})
    @config  = config
    @options = options
  end

  def up
    res = nfs
    res = mpi if res
    network if res
  end

  def nfs
    system('vagrant up nfs --provider=virtualbox')
  end

  def mpi
    nodes = (0...@config[:node_num]).map { |i| "mpi#{i}" }.join(' ')
    system("vagrant up #{nodes} --provider=docker")
  end

  def network
    ids = `docker ps -q`.split("\n").join(' ')
    return false if ids.empty?

    json       = `docker inspect #{ids}`
    ips        = JSON.parse(json).map { |j| j['NetworkSettings']['IPAddress'] }.join(',')
    login_user = @config[:login_user]
    home       = @config[:home]

    ENV['PDSH_SSH_ARGS'] = '-i insecure_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    res = system("vagrant ssh nfs -c 'echo vagrant | sudo -S /data/scripts/cleanup.sh'")
    res = system("pdsh -R ssh -l #{login_user} -w #{ips} #{home}/copy_ssh_files.sh") if res
    res = system("pdsh -R ssh -l #{login_user} -w #{ips} #{home}/setup_ssh.sh") if res
    system("vagrant ssh nfs -c 'echo vagrant | sudo -S /data/scripts/make_hostfile.sh'") if res
  end
end
