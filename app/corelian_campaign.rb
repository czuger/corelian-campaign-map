# check_oauth.rb
require 'sinatra'
require 'sinatra/activerecord'
# require 'sinatra/cors'
require 'json'
require 'securerandom'

require 'omniauth-oauth2'
require 'omniauth-discord'

# require_relative 'models/ls/token'
require_relative 'models/campaign'
require_relative 'engine'
require_relative 'auth'
require_relative 'campaigns'

# Thanks to : http://sinatrarb.com/extensions.html
# and : https://gist.github.com/fairchild/1442227

use Rack::Session::Cookie, :secret => 'foo', :key => 'corelian_campaign_session'

# register Sinatra::Engine
# register Sinatra::Auth

settings = File.read("#{Dir.getwd}/config/settings.json")
settings = JSON.parse(settings)

# set :sessions, true
# set :session_secret, (ENV['CC_SESSION_SECRET'].to_s == '' ? SecureRandom.base64 : ENV['CC_SESSION_SECRET'])
set :database_file, "#{Dir.getwd}/config/database.yml"
set :port, settings['port']

  # set :allow_origin, '*'
  # set :allow_methods, 'GET,HEAD,POST,OPTIONS'
  # set :allow_headers, 'content-type,if-modified-since'
  # set :expose_headers, 'location,link'

use OmniAuth::Builder do
  provider :discord, settings['discord_auth_id'], settings['discord_auth_key']
end

get '/' do
  authorize!
  redirect '/campaigns'
end