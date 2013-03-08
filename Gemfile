source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem 'devise'
gem 'devise-encryptable'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem 'json'
gem 'modernizr-rails'

group :assets do
	gem 'sass-rails', '~> 3.2'
  gem 'bootstrap-sass', '~> 2.3.0.1'
	gem 'coffee-rails'
	gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'rvm-capistrano', '1.3.0.rc11' # SMELL tracking a release candidate - needed for new features 
end

# To use debugger
# gem 'ruby-debug'

group :test, :development do
  gem 'rspec'#, '~> 2.70'
  gem "rspec-rails"
  gem "webmock"
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


