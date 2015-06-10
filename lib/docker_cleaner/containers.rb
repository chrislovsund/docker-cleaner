module DockerCleaner
  class Containers
    def run
      puts "Remove stopped container which stopped with code '0'"
      amount_total = Docker::Container.all.size + 1
      amount_tried = 0
      amount_removed = 0
      puts "Start cleaning, found #{amount_total} containers ..."
      Docker::Container.all(all: true).each do |container|
        begin
          amount_tried += 1
          $stdout.write "Trying to remove container #{amount_tried}/#{amount_total} #{container.id[0...10]} - #{container.info["Image"]}  - #{container.info["Status"]}"
          container.remove
          $stdout.write "... OK\n"
          amount_removed += 1
        rescue Docker::Error::ServerError => e
          puts "   ! ServerError #{e}"
        rescue Docker::Error::TimeoutError => e
          puts "   Timeout when removing #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
          puts "   !     #{e}"
        rescue Docker::Error::NotFoundError => e
          puts "   !     #{e.response.body}"
        rescue Excon::Errors::Conflict => e
          puts "   Conflict when removing #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
          puts "   !     #{e.response.body}"
        rescue StandardError => e
          puts "   General errors when removing #{container.id[0...10]} - #{container.info["Image"]} - "
          pp e
          pp container
        end
        puts "so far #{amount_removed} of #{amount_total} have been removed."
      end
      puts "Container cleaning completed, removed #{amount_removed} of #{amount_total} containers."      
    end
  end
end
