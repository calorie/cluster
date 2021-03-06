require 'json'

class Mpi
  def initialize(config, options)
    @config  = config
    @options = options
  end

  def up_production
    mpi = @config[:mpi]
    remotes = mpi.map do |node|
      user = @config[:login_user]
      host = node[:ip] || node[:host]
      create_json(user, host)
      "#{user}@#{host}"
    end
    puts 'Bootstrap nodes...'
    system("cd mpi/chef-repo && (echo #{remotes.join(' ')} | xargs -P #{remotes.count} -n 1 bundle exec knife solo bootstrap) && cd ../..")
  end

  def up_staging
    create_json(@config[:login_user], 'mpi') unless default_nfs_ip?
    nodes = (0...@config[:node_num]).map { |i| "mpi#{i}" }.join(' ')
    system("vagrant up #{nodes} --provider=docker")
  end

  def halt_production
    mpi     = @config[:mpi]
    user    = @config[:login_user]
    remotes = mpi.map { |node| node[:ip] || node[:host] }.join(',')
    system("pdsh -R ssh -l #{user} -w #{remotes} 'sudo shutdown -h now'")
  end

  def halt_staging
    nodes = (0...@config[:node_num]).map { |i| "mpi#{i}" }.join(' ')
    system("vagrant destroy -f #{nodes}") unless nodes.empty?
  end

  private

  def create_json(user, host)
    nodes_dir = File.join('mpi', 'chef-repo', 'nodes')
    host_json = File.join(nodes_dir, "#{host}.json")
    return true if File.exist?(host_json) && host != 'mpi'

    mpi_json = File.join(nodes_dir, 'mpi.json')
    unless File.exist?(mpi_json)
      puts "#{mpi_json} is not found."
      exit 1
    end

    hash = JSON.parse(File.read(mpi_json))
    hash['user'] = user
    hash['nfs']['server_ip'] = @config[:nfs][:ip]
    File.write(host_json, hash.to_json)
  end

  def default_nfs_ip?
    @config[:nfs][:ip] == '192.168.33.10'
  end
end
