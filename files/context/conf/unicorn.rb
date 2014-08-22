APP_PATH = "/app"

working_directory APP_PATH
worker_processes 3

preload_app true
timeout 30
listen "#{APP_PATH}/tmp/sockets/unicorn.sock"

pid "#{APP_PATH}/tmp/pids/unicorn.pid"
stderr_path "#{APP_PATH}/log/unicorn.error.log"
stdout_path "#{APP_PATH}/log/unicorn.log"

before_fork do |server, worker|
  old_pid = APP_PATH + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
