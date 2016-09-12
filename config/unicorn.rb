worker_processes Integer(ENV["UNICORN_WORKERS"] || 2)
timeout 25
preload_app true

#listen "/app/tmp/sockets/unicorn.sock"

before_fork do |server, worker|
  Signal.trap 'SIGTERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end 

after_fork do |server, worker|
  Signal.trap 'SIGTERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end