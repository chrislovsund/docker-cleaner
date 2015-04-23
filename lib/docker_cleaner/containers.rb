module DockerCleaner
  class Containers
    def run
      puts "Remove stopped container which stopped with code '0'"
      Docker::Container.all(all: true).each do |container|
        begin
          $stdout.write "Remove #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
          container.remove
          $stdout.write "... OK\n"
        rescue Docker::Error::ServerError => e
          puts "   ! ServerError #{e}"
        rescue Docker::Error::TimeoutError => e
          puts "   Timeout when removing #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
          puts "   !     #{e.response.body}"
        rescue Docker::Error::NotFoundError => e
          puts "   !     #{e.response.body}"
        rescue Excon::Errors::Conflict => e
          puts "   Conflict when removing #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
          puts "   !     #{e.response.body}"
        end
      end
    end
  end
end
