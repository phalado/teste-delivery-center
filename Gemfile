# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'rest-client', '~> 2.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.17'
  gem 'rspec-rails'
  gem 'rubocop', '~> 1.12', '>= 1.12.1'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'shoulda-callback-matchers', '~> 1.1.4'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', '~> 0.21.2'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
