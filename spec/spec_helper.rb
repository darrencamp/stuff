# SOURCE: https://gist.github.com/stevenharman/2321262

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'webmock/rspec'
require 'factory_girl'
require 'factory_girl_rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  # NOTE Doesn't appear to be a setting. Assume this was deprecated
  #config.infer_base_class_for_anonymous_controllers = false

  # NOTE: Not sure what these things do. Hints at helpers for specific operations, but no impl. 
  #  Must either need to be coded, or exist in libraries somewhere [tom]
  # config.include JsonSpec::Helpers
  # config.include LoginHelper, type: :request
  # config.include ActivitySpecHelper, type: :request
  # config.include RoomSpecHelper, type: :request
  # config.include AutocompleteSpecHelper, type: :request

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before type: :model do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  # Request specs cannot use a transaction because Capybara runs in a
  # separate thread with a different database connection.
  config.before type: :request do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  # Reset so other non-request specs don't have to deal with slow truncation.
  config.after type: :request  do
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    WebMock.disable_net_connect!(:allow_localhost => true)
    ActionMailer::Base.deliveries.clear
  end

  config.after do
    Timecop.return
    DatabaseCleaner.clean
  end
end

Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 5
Capybara.ignore_hidden_elements = false