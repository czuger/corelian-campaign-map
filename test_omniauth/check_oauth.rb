require 'sinatra'
require 'omniauth'
require 'omniauth-discord'
# require 'omniauth/authenticity_token_protection'
# require 'sinatra/cors'
require 'json'

use Rack::Session::Cookie, :secret => 'foo'
# use OmniAuth::Strategies::Developer
# use OmniAuth::Strategies::Discord
# use OmniAuth::AuthenticityTokenProtection


# configure do
#   set :sessions, true
#   set :session_secret, (ENV['CC_SESSION_SECRET'].to_s == '' ? SecureRandom.base64 : ENV['CC_SESSION_SECRET'])
# end

# For the next time :
# Remember : /auth/:provider is a POST
# Need the CRFS token in the POST
use OmniAuth::Builder do
  settings = File.read('settings.json')
  settings = JSON.parse(settings)

  provider :discord, settings['discord_auth_id'], settings['discord_auth_key']
end

get '/' do
  haml :login
end

get'/auth/:name/callback' do
  auth = request.env['omniauth.auth']
  # do whatever you want with the information!
  auth.to_json
end

# post '/auth/:name/callback' do
#   auth = request.env['omniauth.auth']
#   # do whatever you want with the information!
# end

get '/auth/failure' do
  p params['message']
end
