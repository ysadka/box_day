source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.3'

gem 'pg'

gem 'coffee-rails', '~> 4.0.0'
gem 'figaro'
gem 'foundation-rails'
gem 'haml'
gem 'iron_mq'
gem 'iron_worker_ng'
gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'twitter'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'guard'
  gem 'guard-rspec'
end

group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'parallel_tests'
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'rspec-rails', '>= 2.14'
  gem 'shoulda-matchers'
  gem 'zeus', '>= 0.13.4.pre2'
end

group :test do
  gem 'capybara-webkit', '>= 1.0.0'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov', require: false
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.6.7'
  gem 'rails_12factor'
end
