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

      def admin?
        u = current_user
        Player.where(user_id: u.id, campaign_id: @campaign.id, admin: true).exists?
      end

      def empire_button(player)
        if @admin
          btn_type = player.side == 'empire' ? 'btn-primary' : 'btn-light'
          "<a href='/campaign/#{@campaign.id}/add_player/#{player.id}/empire/update' class='btn #{btn_type} btn-block'>Empire</a>"
        else
          'Empire' if player.side == 'empire'
        end
      end

      def rebel_button(player)
        if @admin
          btn_type = player.side == 'rebel' ? 'btn-primary' : 'btn-light'
          "<a href='/campaign/#{@campaign.id}/add_player/#{player.id}/rebel/update' class='btn #{btn_type} btn-block'>Rebel</a>"
        else
          'Rebel' if player.side == 'rebel'
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

        @campaign = Campaign.find(params['campaign_id'])

        if admin?
          unless Player.where(user_id: params['user_id'], campaign_id: @campaign.id).exists?
            Player.create!(user_id: params['user_id'], campaign_id: @campaign.id, side: params['side'])
          end
        end

        redirect "campaign/#{campaign_id}/players"
      end

      app.get '/campaign/:campaign_id/add_player/:user_id/:side/update' do
        authorize!

        @campaign = Campaign.find(params['campaign_id'])

        if admin?
          player = Player.where(user_id: params['user_id'], campaign_id: @campaign.id).take
          player.side = params['side']
          player.save!
        end

        redirect "campaign/#{@campaign.id}/players"
      end

      app.get '/campaign/:campaign_id/players' do
        authorize!

        @campaign = Campaign.find(params[:campaign_id])

        @admin = admin?
        @players = @campaign.players.includes(:user)

        haml :'campaigns/players'
      end
    end
  end

  register Campaigns
end
