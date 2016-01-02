root = "/var/www/pollster"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "#{root}/tmp/unicorn.pollster.sock"
worker_processes 2
timeout 30
