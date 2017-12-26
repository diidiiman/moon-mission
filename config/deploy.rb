# config valid only for current version of Capistrano
lock "3.10.0"

set :application, "mooner"
set :repo_url, "git@github.com:digipulseio/moon-mission.git"

set :deploy_to, '/home/ubuntu/mooner'
set :bundle_gemfile,  "Gemfile"

set :whenever_roles, [ :app ]

set :linked_dirs, %w{log tmp/pids pids public/system public/deploy exittmp/cache tmp/sockets vendor/bundle unicorn/pids}

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :rails_env, :production


# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  database.yml
  unicorn.rb
  unicorn_init.sh
))


# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtual hosts, log rotation
# init scripts etc.
set(:symlinks, [
    {
        source: "nginx.conf",
        link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
    },
    {
        source: "unicorn_init.sh",
        link: "/etc/init.d/unicorn_mooner"
    }
])

# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, 'deploy:check_revision'

  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'

  # remove the default nginx configuration as it will tend to conflict with our configs.
  before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from setup_config
  after 'deploy:setup_config', 'nginx:reload'

  # As of Capistrano 3.1, the `deploy:restart` task is not called automatically.
  after 'deploy:publishing', 'deploy:restart'

  # Clear public/deploy file cache storage on :primary role
  after :deploy, 'clear_cache:remove_all'

  after :finishing, 'deploy:cleanup'
  after :deploy, 'newrelic:notice_deployment'

  after 'deploy:publishing', 'deploy:restart'

  after 'deploy:published', 'restart' do
    invoke 'delayed_job:restart'
  end
end
