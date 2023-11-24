# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'support/aasm_matchers'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
require 'rspec-benchmark'
require 'shoulda/matchers'
require 'vcr'
require 'aasm'
require 'aasm/rspec'
puts 'AASM is required.'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include ActionDispatch::TestProcess
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include(Requests::JsonHelpers, type: :request)
  config.include(Requests::AuthHelpers, type: :request)
  config.include(Requests::UrlHelpers, type: :request)
  config.include(ActiveJob::TestHelper, type: :request)

  config.include RSpec::Benchmark::Matchers

  # Delete local carrierwave test files
  config.after(:suite) do
    FileUtils.remove_dir("#{Rails.root}/public/uploads") if Dir.exist?("#{Rails.root}/public/uploads")
    Role.delete_all
  end

  # Always have roles available
  config.before(:suite) do
    Role::PERMITTED.values.each do |role|
      Role.find_or_create_by!(name: role)
    end
  end
end
