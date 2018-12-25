require 'logger'
require 'socket'

class Server
  def initialize( port, ip )
    @cola = []
    @server = TCPServer.open( ip, port )
    @log = Logger.new('server_log.log')
    @value = nil
    run
  end

  def run
    puts "Server running"
    loop {
      Thread.start(@server.accept) do | client |
        nick_name = client.gets.chomp
        
        puts "#{nick_name} #{client}"
        
        client.puts "Connection established"

        @log.info("Client logged #{nick_name} - id: #{client}")

        show_options(client, nick_name)

      end
    }.join
  end

  def show_options( client, nick_name )
    loop {
    client.puts 
    client.puts "--------Options--------"
    client.puts "Enter 1 - Synchronous Job"
    client.puts "Enter 2 - Enqueue a Job"
    client.puts "Enter 3 - Enqueue a Job in X Seconds"

    msg = client.gets.to_i
    case msg
        when 1
          job_synchronous(client, nick_name)
        when 2
          enqueue_job(client, nick_name)
        when 3
          timer_enqueue_job(client, nick_name)
        end
    }
  end

  def job_synchronous( client, nick_name )
    puts client
    puts "Synchronous Job Completed to #{nick_name}"
    client.puts "Job Synchronous Completed 'Hello #{nick_name}'"
    @log.info("Job Synchronous Completed for #{nick_name} (Option 1)")
  end

  def enqueue_job( client, nick_name )
    time_job = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    id = @cola.push time_job
    puts "Enqueue Job: #{@cola}"
    
    pos = @cola.size()-1  # Last Position
    @value = @cola[pos].object_id  # Unique Identifier
    client.puts "\a Enqueue Job id: #{@value}"
    @log.info("Enqueue Job (#{@value}) for #{nick_name} (Option 2)")
  end

  def timer_enqueue_job( client, nick_name )
    timer = Thread.new { 
      client.puts "In how many Seconds you want enqueue the job?"
      seconds = client.gets.to_i
      client.puts "Wait #{seconds} seconds..."
      sleep seconds
      id = @cola.push Time.now
      puts "Enqueue Job: #{@cola}"
      
      pos = @cola.size()-1  # Last Position
      @value = @cola[pos].object_id  # Unique Identifier
      client.puts "\a Enqueue Job id: #{@value}"
      @log.info("Enqueue Job (#{@value}) in #{seconds} seconds for #{nick_name} (Option 3)")
    }
    timer.join
  end
end

Server.new( 3000, "localhost" )