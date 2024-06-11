# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Whitelisted domains
    origins(
      /([\w-]*\.?)?optigate-app\.herokuapp\.com\z/,
      /([\w-]*\.?)?optigate\.com\z/,
      'http://localhost:3000',
      'http://localhost:3001'
    )

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose:  ['access-token', 'expiry', 'token-type', 'uid', 'client']
  end
end
