class Downer
  def initialize(config, options = {})
    @config  = config
    @options = options
  end

  def down
    res = nfs
    mpi if res
  end

  def nfs
    system('vagrant halt nfs')
  end

  def mpi
    nodes = (0...@config[:node_num]).map { |i| "mpi#{i}" }.join(' ')
    system("vagrant destroy -f #{nodes}") unless nodes.empty?
  end
end
