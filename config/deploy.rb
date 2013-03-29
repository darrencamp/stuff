# NOTE Move require "bundler/capistrano" to end of file if using 'set :bundle_roles'  
require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'

#load 'config/recipes/rvm'

# Git-related settings
default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :ssh_options, { :forward_agent => true }
#set :ssh_user, 'tom'
# ssh_options[:verbose] = :debug
#ssh_options[:auth_methods] = %w(publickey)
#ssh_options[:keys] = %w(~/.ssh/id_rsa)

set :scm, "git"
set :repository,  "https://github.com/darrencamp/stuff"

set :use_sudo, false
set :user, "stuff" # TODO Need to change this to a 'deploy' user or similar
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }
set(:deploy_to){ "/home/#{user}/web/#{rails_env}"}
set :keep_releases, 5

before "deploy:assets:precompile", 'deploy:symlink_shared'

namespace :deploy do

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end



namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

after "deploy", "rvm:trust_rvmrc"
#before 'deploy:setup', 'rvm:install_ruby' 

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# # TODO Need proper domain names
# role :web, "198.58.106.171"                          # Your HTTP server, Apache/etc
# role :app, "198.58.106.171"                          # This may be the same as your `Web` server
# role :db,  "198.58.106.171", :primary => true # This is where Rails migrations will run
# #role :db,  "your slave db-server here"



# SMELL dodgey town
# namespace :deploy do
#   desc "Create base application folder"
#   task :create_app_dir do
#     run "#{sudo} mkdir -p /var/www/#{application}"
#     run "#{sudo} chown -R tom /var/www/#{application}"
#   end
# end
#     
# before "deploy:setup", "deploy:create_app_dir"

# namespace :deploy do
#   desc "Install everyitem onto the server"
#   task :install do
#     run "#{sudo} apt-get -y update"
# 
#     # Common dependencies
#     run "#{sudo} apt-get -y install curl git-core build-essential python-software-properties"
#     run "#{sudo} apt-get -y install sudo apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion"
# 
#     # Set timezone to UTC
#     run "#{sudo} bash -c 'echo UTC > /etc/timezone'"
#     run "#{sudo} cp /usr/share/zoneinfo/UTC /etc/localtime"
#     run "#{sudo} dpkg-reconfigure -f noninteractive tzdata"
#   end
# end
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# require File.expand_path(__FILE__) + '/../recipes/rvm'
