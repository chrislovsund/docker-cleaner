require 'json'
require 'pp'

class ConfigReader
  def initialize filename
    @config = []
    custom_whitelist_images = []
    begin
      file = File.read(filename)
      @config = JSON.parse(file)
      if @config["whitelist"]
        custom_whitelist_images = @config["whitelist"]["images"]
      end
    rescue Errno::ENOENT => e
      puts "   !     #{e}"
    end
    default_whitelist_images = [
      "ruby:2.1-onbuild",
      "chrislovsund/docker-cleaner:latest",
      "docker.io/chrislovsund/docker-cleaner:latest"
    ]
    @whitelist_images = (default_whitelist_images + custom_whitelist_images)
  end

  def whitelist_images
    return @whitelist_images
  end
end
