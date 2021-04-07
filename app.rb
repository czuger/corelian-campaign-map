# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cors'
require 'json'

require_relative 'models/token'

set :allow_origin, '*'
set :allow_methods, 'GET,HEAD,POST,OPTIONS'
set :allow_headers, 'content-type,if-modified-since'
set :expose_headers, 'location,link'

set :database, {adapter: 'sqlite3', database: 'db/dev.sqlite3'}

# routes...
get '/' do
  tokens = Token.all
  tokens.to_a.to_json
end


post '/add_position' do
  location = params['location']
  status = params['status']

  token = Token.where(location: location).first_or_initialize{ |t|
    t.status = status
  }
  token.save!

end

post '/modify_position' do
  location = params['location']
  status = params['status']

  p location

  token = Token.where(location: location).take
  token.status = status
  token.save!
end