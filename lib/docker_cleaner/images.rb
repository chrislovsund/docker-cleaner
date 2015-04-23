module DockerCleaner
  class Images
    def run
      Excon.defaults[:read_timeout] = 120
      clean_old_images
      clean_unnamed_images
    end

    def clean_unnamed_images
      Docker::Image.all.select do |image|
        image.info["RepoTags"][0] == "<none>:<none>"
      end.each do |image|
        puts "Remove unnamed image #{image.id[0...10]}"
        begin
          image.remove
        rescue Docker::Error::NotFoundError => e
          puts "   !     #{e.response.body}"
        rescue Excon::Errors::Conflict => e
          puts "   #{e.response.body}"
        end
      end
    end

    def clean_old_images
      Docker::Image.all.each do |image|
        if !["ruby:2.1-onbuild", "chrislovsund/docker-cleaner:latest"].include?(image.info["RepoTags"][0])
          begin
            puts "Deleting image #{image.id[0..10]}."
            puts "   Info: #{image.info}"
            puts "   Tags: #{image.info['RepoTags']}"
            image.remove(:force => true)
          rescue Docker::Error::TimeoutError => e
            puts "   Timeout when removing #{image.info['RepoTags'][0]} - ID: #{image.id[0...10]}"
            puts "   !     #{e.response.body}"
          rescue Docker::Error::NotFoundError => e
            puts "   !     #{e.response.body}"
          rescue Excon::Errors::Conflict => e
            puts "   Conflict when removing #{image.info['RepoTags'][0]} - ID: #{image.id[0...10]}"
            puts "   !     #{e.response.body}"
          end
          puts "... Done"
        else
          puts "Ignoring image #{image.id[0..10]} since it is white listed."
          puts "   Tags: #{image.info['RepoTags']}"
        end
      end
    end
  end
end
