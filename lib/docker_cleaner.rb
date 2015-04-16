require 'docker_cleaner/containers'
require 'docker_cleaner/images'

module DockerCleaner
  def self.run
    DockerCleaner::Containers.new.run
    DockerCleaner::Images.new.run
  end
end
