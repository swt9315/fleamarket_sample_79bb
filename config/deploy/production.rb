server '54.95.64.121', user: 'ec2-user', roles: %w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"