require "bundler/capistrano"

set :application, "printcss_imager"
set :repository,  "git://github.com/eabraham/printcss-imager.git"

set :scm, :git
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.printcssimager.com"                          # Your HTTP server, Apache/etc
role :app, "www.printcssimager.com"                          # This may be the same as your `Web` server
role :db,  "www.printcssimager.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, "deploy"

# It complained about no tty, so use pty... no profile scripts :(
# http://weblog.jamisbuck.org/2007/10/14/capistrano-2-1
default_run_options[:pty] = true

# Don't show so much! (Log levels: IMPORTANT, INFO, DEBUG, TRACE, MAX_LEVEL)
logger.level = Capistrano::Logger::DEBUG

# Since we're using pty, load the path ourselves
set :default_environment, {
  "PATH" => "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH"
}

namespace :deploy do
  desc "Zero-downtime restart of Unicorn"
  task :restart, roles: :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat /tmp/unicorn.printcss_imager.pid`"
  end
 
  desc "Start Unicorn"
  task :start, roles: :app, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end
 
  desc "Stop Unicorn"
  task :stop, roles: :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat /tmp/unicorn.printcss_imager.pid`"
  end

  namespace :assets do
 
    desc <<-DESC
      Run the asset precompilation rake task. You can specify the full path \
      to the rake executable by setting the rake variable. You can also \
      specify additional environment variables to pass to rake via the \
      asset_env variable. The defaults are:

        set :rake,      "rake"
        set :rails_env, "production"
        set :asset_env, "RAILS_GROUPS=assets"

      * only runs if assets have changed (add `-s force_assets=true` to force precompilation)
    DESC
    task :precompile, :roles => :web, :except => { :no_release => true } do
      # Only precompile assets if any assets changed
      # http://www.bencurtis.com/2011/12/skipping-asset-compilation-with-capistrano/
      from = source.next_revision(current_revision)
      if fetch(:force_assets, false) || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ lib/assets/ | wc -l").to_i > 0
        # Just like original: https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy/assets.rb
        run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile"
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
 
  end
 
end
