source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'devise'
gem 'devise-encryptable'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem 'json'
gem 'haml' # SMELL I f*#@ing hate haml - do we have to use it? Slim if u insist, but I still prefer old ERB
gem 'modernizr-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails'
	gem 'coffee-rails'
	gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

group :test, :development do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "pickle"
  gem "capybara"
  gem "launchy"
  gem 'email_spec'
end

group :test do
  gem "cucumber-rails"  
  gem "database_cleaner"
end


