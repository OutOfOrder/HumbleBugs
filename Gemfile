source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '3.2.21'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => [:production]

gem 'rails_12factor', group: :production

gem 'awesome_print'
gem 'airbrake'
gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'sass', '~> 3.2.7'
  gem 'compass-rails', '~> 1.0.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'password_strength'

gem 'acts-as-taggable-on'
gem 'declarative_authorization'
gem 'valid_email'

gem 'gravatarify'

# Use puma as the web server
gem 'puma'
gem 'rack-timeout'

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', :group => [:development, :test]
  gem 'rspec_junit_formatter', :git => 'git@github.com:circleci/rspec_junit_formatter.git'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'ffaker', :group => [:development, :test]
end

#gem 'google_drive', :require => false
