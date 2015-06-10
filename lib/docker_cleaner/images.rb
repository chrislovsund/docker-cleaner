require 'config_reader'

module DockerCleaner
  class Images
    def initialize config
      @config = config || ""
    end

    def run
      Excon.defaults[:read_timeout] = 180
      total_number_of_images = Docker::Image.all.size + 1
      number_of_images_cleaned = 0
      puts "Start cleaning of #{total_number_of_images} found images ..."

      Docker::Image.all.each do |image|
        if ! @config.whitelist_images.include?(image.info["RepoTags"][0])
          begin
            puts "Trying to remove image #{image.id[0..10]} - RepoTags: #{image.info['RepoTags']}"
            image.remove(:force => true)
          rescue Docker::Error::TimeoutError => e
            puts "   Timeout when removing #{image.info['RepoTags']} - ID: #{image.id[0...10]}"
            puts "   !     #{e}"
          rescue Docker::Error::NotFoundError => e
            puts "   !     #{e.response.body}"
          rescue Excon::Errors::Conflict => e
            puts "   Conflict when removing #{image.info['RepoTags']} - ID: #{image.id[0...10]}"
            puts "   !     #{e.response.body}"
          end
          number_of_images_cleaned += 1
          puts "so far #{number_of_images_cleaned} of #{total_number_of_images} have been removed."
        else
          puts "Ignoring image #{image.id[0..10]} since it is white listed."
          puts "   Tags: #{image.info['RepoTags']}"
        end
      end
      puts "Image cleaning completed, removed #{number_of_images_cleaned} of #{total_number_of_images} images."
    end
  end
end
