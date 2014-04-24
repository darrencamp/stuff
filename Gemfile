source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development


# Authentication
gem 'devise'
gem 'devise-encryptable'

# SMELL what do we need these for?
gem 'json'
gem 'redcarpet' 

# UI related 
gem 'bootstrap-sass'#, '~> 2.3.0.1'
gem 'modernizr-rails'
gem 'rails3-jquery-autocomplete'
gem 'rqrcode-rails3'
gem 'best_in_place', :github => 'bernat/best_in_place', :branch => 'rails-4'

gem 'acts-as-taggable-on'

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-unicorn', :require => false
  gem 'rvm-capistrano'#, '1.3.0.rc11' # SMELL tracking a release candidate - needed for new features 
  gem 'quiet_assets'
  gem 'thin' # NOTE Using thin as development webserver as Webrick throws spurious errors
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


