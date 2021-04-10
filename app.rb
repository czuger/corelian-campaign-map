# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cors'
require 'json'
require 'securerandom'

require_relative 'models/token'
require_relative 'models/campaign'

set :allow_origin, '*'
set :allow_methods, 'GET,HEAD,POST,OPTIONS'
set :allow_headers, 'content-type,if-modified-since'
set :expose_headers, 'location,link'

settings = File.read('settings.json')
settings = JSON.parse(settings)

set :database, {adapter: 'sqlite3', database: settings['db']}
set :port, settings['port']

# routes...
get '/' do
  tokens = Token.all
  tokens.to_a.map{to_json
end

get '/imperial' do
  tokens = Token.where(status: 1)
  tokens.to_a.to_json
end

get '/rebels' do
  tokens = Token.where(status: [2, 3])
  tokens.to_a.to_json
end

post '/add_position' do
  location = params['location']
  status = params['status']

  token = Token.where(location: location).first_or_initialize{ |t|
    t.status = 1
  }
  token.save!

end

post '/modify_position' do
  location = params['location']
  status = params['status']

  # p location

  token = Token.where(location: location).take
  token.status = status
  token.save!
end

post '/delete_position' do
  location = params['location']
  # status = params['status']

  # p location

  Token.where(location: location).delete_all
end

post '/new_campaign' do
  Campaign.create!(
      name: params['name'],
      public_key: SecureRandom.hex(12),
      rebels_edit_key: SecureRandom.hex(12),
      rebels_status_key: SecureRandom.hex(12),
      imperial_status_key: SecureRandom.hex(12)
  )

  return 'Ok'
end

get '/list_campaigns' do
  result = []
  host = 'http://localhost:63342/corelian-campaign-map/html'
  random = SecureRandom.alphanumeric(12)

  Campaign.all.each do |c|
    result << {
      'public': "#{host}/index.html?_ijt=#{random}&imperial=true&key=#{c.public_key}",
      'rebels_edit': "#{host}/index.html?_ijt=#{random}&key=#{c.rebels_edit_key}",
      'rebels_status': "#{host}/status.html?_ijt=#{random}&side=imperial&key=#{c.rebels_status_key}",
      'imperial_status': "#{host}/status.html?_ijt=#{random}&side=rebels&key=#{c.imperial_status_key}"
    }
  end

  return result.to_json
end
