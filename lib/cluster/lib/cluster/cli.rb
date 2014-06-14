require 'thor'

class Cli < Thor
  include Thor::Actions
  include Cluster::Base

  desc 'init', 'Initialize cluster'
  def init
    Initializer.new(@@config).bootstrap
  end

  desc 'vagrantfile', 'Make Vagrantfile'
  method_option :force, type: :boolean, aliases: '-f', banner: 'Force create'
  def vagrantfile
    Initializer.new(@@config, options).make_vagrantfile
  end

  desc 'cookbooks', 'Vendor cookbooks'
  method_option :force, type: :boolean, aliases: '-f', banner: 'Force create'
  def cookbooks
    Initializer.new(@@config, options).get_cookbooks
  end

  before_method(*instance_methods(false)) do
    if !File.exist?('config.yaml')
      raise 'config.yaml is not found.'
    else
      @@config = YAML.load_file('config.yaml')
    end
  end
end
