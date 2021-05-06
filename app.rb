# This is for the Rakefile only

require 'sinatra'
require 'sinatra/activerecord'

settings = File.read('app/settings.json')
settings = JSON.parse(settings)

set :database, {adapter: 'sqlite3', database: settings['db']}
