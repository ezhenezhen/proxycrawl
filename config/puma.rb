threads 1, 8
workers 1 # We may bump number of workers in prod but for now let's keep single worker to avoid strange bugs

worker_timeout 3600 if ENV['RACK_ENV'] == 'development'

root = Dir.pwd

preload_app!

rackup "#{root}/config.ru"
bind "unix://#{root}/tmp/sockets/puma.sock"
state_path "#{root}/tmp/pids/puma.state"
pidfile "#{root}/tmp/pids/puma.sock"

on_worker_boot do
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection

  defined?(Redis) &&
    Redis.current = Redis.new(url: ENV['REDIS_URL'])
end

on_restart do
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  defined?(Redis) &&
    Redis.current.quit
end
