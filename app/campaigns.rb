require 'sinatra/base'
require_relative 'models/user'
require_relative 'models/campaign'

module Sinatra
  module Campaigns

    module Helpers
      def side(player)
        if player.side == 'empire'
          'Empire'
        elsif player.side == 'rebel'
          'Rebelle'
        else
          nil
        end
      end
    end

    def self.registered(app)
      app.helpers Campaigns::Helpers

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

      app.get '/campaign/:campaign_id/add_player/new' do
        authorize!

        u = current_user

        @campaign_id = params['campaign_id']
        @users = User.where.not(id: u.id)

        haml :'campaigns/add_player_new'
      end

      app.get '/campaign/:campaign_id/add_player/:user_id/:side/add' do
        authorize!

        u = current_user

        # Check if the current user is admin for the campaign
        campaign_id = params['campaign_id']

        if Player.where(user_id: u.id, campaign_id: campaign_id, admin: true).exists?
          unless Player.where(user_id: params['user_id'], campaign_id: campaign_id).exists?
            Player.create!(user_id: params['user_id'], campaign_id: campaign_id, side: params['side'])
          end
        end

        redirect "campaign/#{campaign_id}/players"
      end

      app.get '/campaign/:campaign_id/players' do
        authorize!

        c = Campaign.find(params[:campaign_id])

        @players = c.players.includes(:user)

        haml :'campaigns/players'
      end
    end
  end

  register Campaigns
end
