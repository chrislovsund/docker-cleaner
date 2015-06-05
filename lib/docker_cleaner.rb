require 'docker_cleaner/containers'
require 'docker_cleaner/images'
require 'config_reader'

module DockerCleaner
  def self.run(config)
    DockerCleaner::Containers.new.run
    DockerCleaner::Images.new(config).run
  end
end
