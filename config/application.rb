require_relative "boot"

require "rails/all"

require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
require 'dotenv/rails-now' if Rails.env.development? || Rails.env.test?
Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module OptigateApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.debug_exception_response_format = :api

    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use config.session_store, config.session_options
    config.twilio_account_sid = 'AC35b268335599de13112f69fec57bb785'
    config.twilio_auth_token = 'e08cd1d87987687e9010031aa835bc8d'
    config.twilio_phone_number = '+923343551128'
  end
end
