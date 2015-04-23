module DockerCleaner
  class Containers
    def run
      puts "Remove stopped container which stopped with code '0'"
      Docker::Container.all(all: true).each do |container|
        if container.info["Status"].include?("Exited (0)") || container.info["Status"].include?("Exited (") 
          $stdout.write "Remove #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
          container.remove
          $stdout.write "... OK\n"
        else
          puts "Ignore running #{container.id[0...10]} - #{container.info["Image"]} - #{container.info["Names"][0]}"
        end
      end
    end
  end
end
