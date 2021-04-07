server '3.22.95.171', user: 'deploy', roles: %w{web app db}
set :rails_env, 'production'
