source 'https://rubygems.org'

gem 'rails', '3.2.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => [:production]


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem 'acts-as-taggable-on'
gem 'declarative_authorization', :git => "https://github.com/stffn/declarative_authorization.git"

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', :group => [:development, :test]
  gem 'awesome_print', :group => [:development, :test]
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'launchy'
end
