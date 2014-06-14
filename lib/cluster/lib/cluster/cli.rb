require 'thor'

class Cli < Thor
  include Cluster::Base

  class_option :production, type: :boolean, aliases: '-p', banner: 'Flag of production'

  desc 'init', 'Initialize cluster'
  method_option :force,     type: :boolean, aliases: '-f', banner: 'Force create'
  method_option :key,       type: :boolean, aliases: '-k', banner: 'Init insecure_key'
  method_option :cookbooks, type: :boolean, aliases: '-c', banner: 'Init Cookbooks'
  method_option :vagrant,   type: :boolean, aliases: '-v', banner: 'Init Vagrantfile'
  def init
    config = options[:production] ? @@config[:production] : @@config[:staging]
    i = Initializer.new(config, options)
    if !options[:key] && !options[:vagrant] && !options[:cookbooks]
      i.bootstrap
    else
      i.insecure_key if options[:key]
      i.cookbooks    if options[:cookbooks]
      i.vagrantfile  if options[:vagrant]
    end
  end

  desc 'up', 'Up cluster'
  method_option :force,   type: :boolean, aliases: '-f', banner: 'Force create'
  method_option :nfs,     type: :boolean, aliases: '-n', banner: 'Up nfs VM'
  method_option :mpi,     type: :boolean, aliases: '-m', banner: 'Up mpi containers'
  method_option :network, type: :boolean, aliases: '-N', banner: 'Setup network'
  def up
    config = options[:production] ? @@config[:production] : @@config[:staging]
    u = Upper.new(config, options)
    if !options[:nfs] && !options[:mpi] && !options[:network]
      u.up
    else
      u.nfs     if options[:nfs]
      u.mpi     if options[:mpi]
      u.network if options[:network]
    end
  end

  desc 'halt', 'Halt cluster'
  method_option :force, type: :boolean, aliases: '-f', banner: 'Force create'
  method_option :nfs,   type: :boolean, aliases: '-n', banner: 'Halt nfs VM'
  method_option :mpi,   type: :boolean, aliases: '-m', banner: 'Halt mpi containers'
  def halt
    config = options[:production] ? @@config[:production] : @@config[:staging]
    d = Downer.new(config, options)
    if !options[:nfs] && !options[:mpi]
      d.down
    else
      d.nfs if options[:nfs]
      d.mpi if options[:mpi]
    end
  end

  before_method(*instance_methods(false)) do
    if !File.exist?('config.yaml')
      raise 'config.yaml is not found.'
    else
      @@config = YAML.load_file('config.yaml')
    end
  end
end
