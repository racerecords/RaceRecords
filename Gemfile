# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'administrate'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'devise'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'jbuilder', '~> 2.5'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'pundit'
gem 'rails', '~> 5.2.2'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'erd'
  gem 'faker'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
