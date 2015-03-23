source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use thin instead of Webrick
gem 'thin'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# User coffeescript for js syntax
gem 'coffee-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# user management via devise because easy = good
gem 'devise'
gem 'devise-async'
# better json serialization
gem 'active_model_serializers'
# user friendly url
gem 'friendly_id'
# Multi-table inheritance
gem 'active_record-acts_as'
# Authorization
gem 'pundit'

# Allow Cross-Origin
gem 'rack-cors', :require => 'rack/cors'

# slim because it's nicer
gem 'slim-rails'

# used by bootstrap-sass
gem 'autoprefixer-rails'

#ember
gem 'ember-rails'
gem 'ember-source'
gem 'emblem-rails'
gem 'ember_script-rails'
gem 'ember_simple_auth-rails'
gem 'ember-easyForm-rails', '~> 1.0.0.beta.2'
gem 'ember-validations-rails', '~> 1.0.0.beta.2'
gem 'momentjs-rails'

# Mixin library, grid framework, and default styles
gem 'bourbon'
gem 'neat'
gem 'bitters'

# Date help
gem 'chronic'

# nice error messages in development
group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: false
  gem 'api_matchers'
  gem 'zeus'
  gem 'teaspoon', git: 'https://github.com/modeset/teaspoon', branch: 'master'
  gem 'guard-teaspoon', git: 'https://github.com/modeset/guard-teaspoon', branch: 'master'
  gem 'ember-data-factory-guy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :production do
  # Heroku
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

