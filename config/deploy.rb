# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'printcss-imager'
set :repo_url, 'https://github.com/eabraham/printcss-imager.git'
set :branch, 'master'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/u/apps/printcss_imager'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc "Zero-downtime restart of Unicorn"
  task :restart do
  	on roles(:web) do
      run "kill -s USR2 `cat /tmp/unicorn.my_app_name.pid`"
    end
  end

  desc "Start Unicorn"
  task :start do
  	on roles(:web) do
      run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
    end
  end
 
  desc "Stop Unicorn"
  task :stop do
  	on roles(:web) do
      run "kill -s QUIT `cat /tmp/unicorn.my_app_name.pid`"
    end
  end 
end
