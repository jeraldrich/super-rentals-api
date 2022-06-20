require 'webmock/rspec'

ENV['RAILS_ENV'] ||= 'test'

# require "simplecov"
# SimpleCov.start :rails do
#   add_group "Services", "app/services"
# end

require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production.
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'spec_helper'
require 'rspec/rails'
require 'rspec/its'
require 'factory_bot_rails'
require 'rspec/collection_matchers'

# Auto require all files and directories in support.
Dir[Rails.root.join('spec/support/*.rb')].sort.each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fail_fast = false
  config.include FactoryBot::Syntax::Methods
  # config.include Features, type: :feature
  # config.include Requests::JsonHelpers, type: :request
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.include Rails.application.routes.url_helpers

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Trucate database on test suite start.
  config.before(:suite) do
    Warden.test_mode!
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset!
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end