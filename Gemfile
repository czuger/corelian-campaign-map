# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"

gem 'sinatra', '~> 2.1'
gem 'sinatra-contrib', '~> 2.1'
gem 'sinatra-activerecord'
# gem 'sinatra-cors'
gem 'sqlite3'
gem 'rake'

gem 'rerun'

gem 'omniauth'
# gem 'omniauth-oauth2'
gem 'omniauth-discord'
# gem 'omniauth-rails_csrf_protection'
# gem 'omniauth-twitter'
# gem 'sinatra_omniauth'
gem 'jwt'

gem 'haml'
# Thin has pool connection issues
# gem 'thin'
gem 'webrick'

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-bundler', '~> 2.0'
  gem 'capistrano-rbenv', '~> 2.2'

  gem 'ed25519', '~> 1.2'
  gem 'bcrypt_pbkdf', '~> 1.0'

  gem 'standalone_migrations'
end