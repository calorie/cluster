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
    insecure_key
    cookbooks
    vagrantfile
  end

  def insecure_key
    insecure_key_path = 'insecure_key'
    FileUtils.rm_rf(insecure_key_path) if @options[:force]
    return if File.exist?(insecure_key_path)
    uri           = URI.parse('https://raw.githubusercontent.com/phusion/baseimage-docker/master/image/insecure_key')
    https         = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request       = Net::HTTP::Post.new(uri.path)
    response      = https.request(request)
    File.write(insecure_key_path, response.body)
    FileUtils.chmod(0600, insecure_key_path)
  end

  def cookbooks
    %w(nfs mpi).each do |node|
      chef_repo = File.join("#{node}", 'chef-repo')
      cookbooks_path = File.join(chef_repo, 'cookbooks')
      FileUtils.rm_rf(cookbooks_path) if @options[:force]
      unless File.exist?(cookbooks_path)
        Dir.chdir(chef_repo) do
          system('bundle exec berks vendor cookbooks')
        end
      end
    end
  end

  def vagrantfile
    vagrantfile_path = 'Vagrantfile'
    return if File.exist?(vagrantfile_path) && !@options[:force]

    template = File.join('template', 'Vagrantfile.erb')
    unless File.exist?(template)
      puts "#{template} is not found."
      exit 1
    end

    _config = @config
    erb     = ERB.new(File.read(template))

    File.write(vagrantfile_path, erb.result(binding))
  end
end
