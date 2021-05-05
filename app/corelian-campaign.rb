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
require_relative 'foo'

# Thanks to : http://sinatrarb.com/extensions.html
# and : https://gist.github.com/fairchild/1442227

class SinatraApp < Sinatra::Base

  register Sinatra::Engine
  register Sinatra::Foo

  configure do
    set :sessions, true
    set :session_secret, (ENV['CC_SESSION_SECRET'].to_s == '' ? SecureRandom.base64 : ENV['CC_SESSION_SECRET'])

    settings = File.read('settings.json')
    settings = JSON.parse(settings)

    set :database, {adapter: 'sqlite3', database: settings['db']}
    set :port, settings['port']

    # set :allow_origin, '*'
    # set :allow_methods, 'GET,HEAD,POST,OPTIONS'
    # set :allow_headers, 'content-type,if-modified-since'
    # set :expose_headers, 'location,link'

  # OmniAuth.configure do |config|
  #   # Always use /auth/failure in any environment
  #   config.failure_raise_out_environments = []
  # end

  # get '/auth/:provider/callback' do
  #   erb "<h1>#{params[:provider]}</h1>
  #        <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
  # end

    use OmniAuth::Builder do
      settings = File.read('settings.json')
      settings = JSON.parse(settings)

      p settings

      provider :discord, settings['discord_auth_id'], settings['discord_auth_key'], strategy_class: OmniAuth::Strategies::Discord
      provider :developer

      Sinatra::Application.routes['GET'].each do |route|
        p route[0]
      end
    end
  end

  # get '/auth/:provider/callback' do
  #   erb "<h1>#{params[:provider]}</h1>
  #        <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
  # end

end

# SinatraApp.run! if __FILE__ == $0
