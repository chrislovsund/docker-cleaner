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
        rescue Docker::Error::NotFoundError
        rescue Excon::Errors::Conflict => e
          puts "   #{e.response.body}"
        end
      end
    end

    def clean_old_images
#      one_week_ago = Time.now.to_i - 7 * 24 * 3600
      Docker::Image.all.each do |image|
#        if image.info["Created"].to_i < one_week_ago
          begin
            puts "Deleting image #{image.id[0..10]}."
            puts "   Info: #{image.info}"
            puts "   Tags: #{image.info['RepoTags']}"
            image.remove(:force => true)
          rescue Docker::Error::NotFoundError
          rescue Excon::Errors::Conflict => e
            puts "   Conflict when removing #{image.info['RepoTags'][0]} - ID: #{image.id[0...10]}"
            puts "   !     #{e.response.body}"
          end
          puts "... Done"
#        else
#          puts "Ignoring image #{image.id[0..10]} since was created less than one week ago."
#          puts "   Tags: #{image.info['RepoTags']}"
 #       end
      end
    end
  end
end
