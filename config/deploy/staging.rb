set :application, "stuff-staging"
set :branch, "develop" 

server 'stuff.staging.eventidesystems.com', :app, :web, :primary => true

set :rails_env, 'staging'

set :rvm_ruby_string, '1.9.3@stuff-staging'
set :rvm_type, :user

require 'rvm/capistrano'