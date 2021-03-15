ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require 'database_cleaner'
require 'capybara/rspec'
require 'shoulda/matchers'

require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'

abort("The Rails environment is running in production mode!") if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  # Factory Bot Rails
  config.include FactoryBot::Syntax::Methods

  # Devise Test Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  
  #Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.before(:all) do
    DatabaseCleaner.start
  end
  config.after(:all) do
    DatabaseCleaner.clean
  end

  #Capybara
  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def capybara_login(user)
  visit new_user_session_path
  fill_in('Email', with: user.email)
  fill_in('Password', with: user.password)
  click_on('Log In')
end
