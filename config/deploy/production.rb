set :application, "stuff"
set :branch, "master" 

server 'stuff.eventidesystems.com', :app, :web, :primary => true

set :rails_env, 'production'