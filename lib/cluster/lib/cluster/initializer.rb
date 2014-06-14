require 'net/https'
require 'fileutils'
require 'yaml'
require 'erb'

class Initializer
  def initialize(config, options = {})
    @config  = config
    @options = options
  end

  def bootstrap
    get_insecure_key
    get_cookbooks
    make_vagrantfile
  end

  def get_insecure_key
    return if File.exist?('insecure_key')
    uri           = URI.parse('https://raw.githubusercontent.com/phusion/baseimage-docker/master/image/insecure_key')
    https         = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request       = Net::HTTP::Post.new(uri.path)
    response      = https.request(request)
    File.write('insecure_key', response.body)
    FileUtils.chmod(0600, 'insecure_key')
  end

  def get_cookbooks
    %w(nfs mpi).each do |node|
      chef_repo = File.join("#{node}", 'chef-repo')
      cookbooks = File.join(chef_repo, 'cookbooks')
      FileUtils.rm_rf(cookbooks) if @options[:force]
      unless File.exist?(cookbooks)
        Dir.chdir(chef_repo) do
          system('bundle exec berks vendor cookbooks')
        end
      end
    end
  end

  def make_vagrantfile
    vagrantfile = 'Vagrantfile'
    return if File.exist?(vagrantfile) && !@options[:force]

    template = File.join('template', 'Vagrantfile.erb')
    raise "#{template} is not found." unless File.exist?(template)

    _config = @config
    erb     = ERB.new(File.read(template))

    File.write(vagrantfile, erb.result(binding))
  end
end
