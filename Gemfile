source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-sass'
gem 'browser'
gem 'holiday_jp'
gem 'jbuilder'
gem 'jquery-rails'
gem 'kaminari'
gem 'meta-tags'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'newrelic_rpm'
gem 'pry-rails'
gem 'pry-byebug'
gem 'pry-stack_explorer'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'rubocop', require: false
gem 'sass-rails', '~> 5.0'
gem 'settingslogic'
gem 'slim-rails'
gem 'sorcery'
gem 'trading_day_jp', github: 'tyn-iMarket/trading_day_jp'
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'exception_notification'
end

group :development, :test do
  gem 'factory_bot_rails'
end

group :development do
  gem 'better_errors'
  gem 'foreman'
  gem 'rack-proxy'
  gem 'seed-fu'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem "rspec_junit_formatter"
  gem 'rspec-rails'
  gem 'rubocop-rspec'
  gem 'spring-commands-rspec'
  gem 'timecop'
end
