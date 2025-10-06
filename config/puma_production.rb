# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 5

plugin :tmp_restart

preload_app!

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
bind "unix://#{shared_dir}/sockets/estagios_semasc.sock"
bind "tcp://0.0.0.0:3077"
#bind 'ssl://0.0.0.0:3001?key=/etc/letsencrypt/live/estagios_semasc.com.br/privkey.pem&cert=/etc/letsencrypt/live/estagios_semasc.com.br/cert.pem'

# Logging
stdout_redirect "#{shared_dir}/log/estagios_semasc.stdout.log", "#{shared_dir}/log/estagios_semasc.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/estagios_semasc.pid"
state_path "#{shared_dir}/pids/estagios_semasc.state"
activate_control_app
