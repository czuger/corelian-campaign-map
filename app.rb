# app.rb
require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/token'

# Use https://github.com/cjheath/sinatra_omniauth/tree/master/models
# For login

set :database, {adapter: 'sqlite3', database: 'db/dev.sqlite3'}

get '/' do
  Token.create( pic_name: :foo, location: :bar )
end