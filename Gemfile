source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem 'pg_search'
gem "puma", "~> 5.0"
gem 'devise_token_auth'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem 'shrine'
gem "rack-cors"
gem 'graphiql-rails'
gem 'graphql', '~> 1.10'
gem 'graphql-guard', '~> 1.3'
gem 'twilio-ruby'


group :development, :test do
  gem 'awesome_print'
  gem 'bullet'
  gem 'byebug'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'dotenv-rails', require: 'dotenv/rails-now' 
  gem 'aasm'
end

group :development do
  gem 'better_errors'
  gem 'listen'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'rspec-benchmark'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'vcr'
  gem 'webmock'
end

gem 'stripe'
#active admin
gem 'devise'
gem 'activeadmin'
gem 'sprockets', '<4'
gem 'sass-rails'