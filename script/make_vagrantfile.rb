require 'yaml'
require 'erb'

project_root = File.join(File.dirname(__FILE__), '..')
yaml         = File.join(project_root, 'config.yaml')
template     = File.join(project_root, 'template', 'Vagrantfile.erb')
vagrantfile  = File.join(project_root, 'Vagrantfile')

[yaml, template].each do |f|
  unless File.exist?(f)
    puts "#{f} not found."
    exit 1
  end
end

_config = YAML.load_file(yaml)
erb     = ERB.new(File.read(template))

File.write(vagrantfile, erb.result(binding))
