require 'sinatra/base'
require_relative 'models/user'
require_relative 'models/campaign'

module Sinatra
  module Campaigns

    def self.registered(app)

      app.get '/campaigns' do
        authorize!

        @players = current_user.players.includes(:campaign)
        haml :'campaigns/list'
      end

      app.get '/campaign/new' do
        authorize!

        haml :'campaigns/new'
      end

      app.post '/campaign/create' do
        authorize!

        name = params['campaign_name']

        ActiveRecord::Base.transaction do
          c = Campaign.create!(name: name)
          u = current_user

          Player.create!(user_id: u.id, campaign_id: c.id, admin: true)

          redirect '/campaigns'
        end
      end
    end
  end

  register Campaigns
end
