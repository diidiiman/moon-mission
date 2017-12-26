# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "ec2-34-253-237-84.eu-west-1.compute.amazonaws.com", user: "ubuntu", roles: %w{app db web primary cron}
server "ec2-54-229-92-13.eu-west-1.compute.amazonaws.com", user: "ubuntu", roles: %w{app db cron}

set :deploy_user, 'ubuntu'
set :deploy_to, '/home/ubuntu/mooner'
set :full_app_name, 'mooner.io'
set :app_name, 'mooner'
set :server_name, 'mooner.io'
set :unicorn_worker_count, 4
set :rails_env, 'production'

set :delayed_job_server_roles, :cron
set :delayed_job_workers, 3

set :rbenv_type, :user
set :rbenv_ruby, '2.4.3'