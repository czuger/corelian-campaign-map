# corelian-campaign.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cors'
require 'json'
require 'securerandom'

require 'omniauth'
require 'omniauth-oauth2'
require 'omniauth-discord'

# require_relative 'models/ls/token'
require_relative 'models/campaign'
require_relative 'engine'
require_relative 'omni_auth'


class SinatraApp < Sinatra::Base

  register Sinatra::Engine
  register Sinatra::OmniAuth

  def initialize

  end

  configure do
    set :sessions, true

    settings = File.read('settings.json')
    settings = JSON.parse(settings)

    set :database, {adapter: 'sqlite3', database: settings['db']}
    set :port, settings['port']

    set :allow_origin, '*'
    set :allow_methods, 'GET,HEAD,POST,OPTIONS'
    set :allow_headers, 'content-type,if-modified-since'
    set :expose_headers, 'location,link'
  end

  use OmniAuth::Builder do
    settings = File.read('settings.json')
    settings = JSON.parse(settings)
    provider :discord, settings['discord_auth_id'], settings['discord_auth_key']
  end

end



SinatraApp.run! if __FILE__ == $0



