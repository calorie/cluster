require 'mkmf'

module Cluster
  module Validator
    module_function

    def docker?
      unless find_executable('docker')
        raise '`docker` command is not found.'
      end
      true
    end

    def pdsh?
      unless find_executable('pdsh')
        raise '`pdsh` command is not found.'
      end
      true
    end

    def vagrant?
      unless find_executable('vagrant')
        raise '`vagrant` command is not found.'
      end
      true
    end
  end
end
