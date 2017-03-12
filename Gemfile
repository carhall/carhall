source 'http://gems.ruby-china.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgresql as the database for Active Record
# gem 'pg'
gem 'mysql2'
gem 'dalli'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'less-rails'
gem "typhoeus"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-migrate-rails'
gem 'jquery-datatables-rails'
gem "select2-rails", '~> 3.5.0'
# gem 'bootstrap-sass'
gem "twitter-bootstrap-rails"
gem 'jasny_bootstrap_extension_rails'
gem 'hermitage'

gem 'zepto-rails', github: 'packetman/zepto-rails'
gem 'ratchet-rails'
gem 'pikaday-gem'

gem 'weixin_rails_middleware', '~> 1.2.4'
gem "weixin_authorize"
gem 'mini_magick'
gem 'multi_json'
# For frontend
gem 'simple_form'
gem 'cocoon'
gem 'show_for', path: 'vendor'
gem 'index_for', path: 'vendor'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'grape'
gem 'grape-entity'

gem 'rest-client'

gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Authentication
gem 'devise', '~> 3.1'
gem 'cancan'

# Basic
gem 'kaminari'
gem 'paperclip'
gem 'rqrcode-rails3'
gem 'mini_magick'
gem 'geohash', github: 'RyanNaughton/geohash'
# gem 'active_enum', github: 'bbtfr/active_enum'
gem 'active_enum', path: 'vendor'
# gem "second_level_cache", github: 'hooopo/second_level_cache'

# gem 'resque'

gem 'spreadsheet'

# Audit

group :development, :test do
  gem 'faker'
  gem 'factory_girl_rails'

  gem 'quiet_assets'
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rspec-rails'

  gem 'yaml_db', github: 'jetthoughts/yaml_db'
end

group :development do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
end
