# NOTE Move require "bundler/capistrano" to end of file if using 'set :bundle_roles'  
require "bundler/capistrano"

load 'config/recipes/rvm'

set :application, "stuff"

# Git-related settings
default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :ssh_options, { :forward_agent => true }

set :scm, "git"
set :repository,  "https://github.com/darrencamp/stuff"
set :branch, "develop" # TODO Change this 'master' when we start rolling production releases

set :user, "tom" # TODO Need to change this to a 'deploy' user or similar
set :deploy_via, :remote_cache

set :keep_releases, 5

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# TODO Need proper domain names
role :web, "198.58.106.171"                          # Your HTTP server, Apache/etc
role :app, "198.58.106.171"                          # This may be the same as your `Web` server
role :db,  "198.58.106.171", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/var/www/{application}"

#before "deploy:setup", "rvm:install_ruby"

# namespace :deploy do
#   desc "Install everything onto the server"
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
