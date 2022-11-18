source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "pg"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise"

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
  gem "pry-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "annotate"
  gem "web-console"
  gem "binding_of_caller"
  gem "better_errors"
end

group :test do
  gem "rspec-rails"
  gem 'rails-controller-testing'
  gem "shoulda-matchers"
  gem "launchy"
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tailwindcss-rails", "~> 2.0"
