require 'sinatra/base'

module Sinatra
  module Engine

    EMPIRE_CYCLE = %w(empire_base destroyed empty)
    REBEL_CYCLE = %w(rebel_base rebel_outpost destroyed empty)
    REBEL_HIDDEN = %w(rebel_base rebel_outpost)

    PICS_CONVERT = {
      'empire_base': '/pics/ImperialBase_sticker.png',
      'rebel_base': '/pics/RebelBase_sticker.png',
      'rebel_outpost': '/pics/RebelOutpost_sticker.png',
      'destroyed': '/pics/PresenceDestroyed_sticker.png',
      'diplomat': '/pics/StratEff_Diplomat.png',
      rebel_presence: '/pics/RebelPresence_sticker.png'
    }

    module Helpers
      def icons_hash
        if current_player.side == 'empire'
          { cycle: EMPIRE_CYCLE, pics_convert: PICS_CONVERT }
        elsif current_player.side == 'rebel'
          { cycle: REBEL_CYCLE, pics_convert: PICS_CONVERT }
        else
          { cycle: [], pics_convert: PICS_CONVERT }
        end
      end
    end

    def self.registered(app)

      app.helpers Engine::Helpers

      # If required, use https://hackernoon.com/how-to-take-screenshots-in-the-browser-using-javascript-l92k3xq7
      # To make a screenshot of the map.

      # TODO : remove the diplomat bool in token if unused.

      app.get '/map/:campaign_id' do
        authorize!

        p :foo

        @campaign = Campaign.find(params['campaign_id'])
        @side = current_player.side

        @tokens_hash = icons_hash
        @tokens_hash[:tokens] = @campaign.tokens.all.to_a

        p current_player
        if current_player.side != 'rebel'
          p @tokens_hash[:tokens]

          for token in @tokens_hash[:tokens]
            token.status = :rebel_presence if REBEL_HIDDEN.include?(token.status)
          end

          p @tokens_hash[:tokens]
        end

        haml :map, layout: :map_layout
      end

      app.post '/map/:campaign_id/set_position/:location/:token' do
        @campaign = Campaign.find(params['campaign_id'])
        location = params['location']
        token = params['token']

        ownership_token = @campaign.tokens.where(location: location).first

        if !ownership_token || ownership_token.owner == current_player.side
          if token == 'empty'
            @campaign.tokens.where(location: location).delete_all
          else
            db_token = @campaign.tokens.where(location: location).first_or_initialize
            db_token.status = token
            db_token.owner = current_player.side
            db_token.save!
          end
        end
      end

      app.get '/status/:campaign_id' do
        authorize!
        @campaign = Campaign.find(params['campaign_id'])
        @side = current_player.side

        loaded_tokens = @campaign.tokens.where(owner: @side).where.not(status: 'destroyed')
        areas_content = YAML.load(File.read('config/areas_content.yml'))

        @tokens = []
        @construction = 0
        @repair = 30
        @diplomats = 0
        @spynets = 0
        @skilled_spacers = 0

        loaded_tokens.each do |e|
          t = areas_content[e.location].dup
          # p t
          
          t.status = e[:status].split('_').last
          
          t.construction = t.construction + (t.status == 'base' ? 25 : 5)
          @construction += t.construction

          t.repair_yards = t.repair_yards ? 5 : 0
          @repair += t.repair_yards

          t.diplomats = t.diplomats ? 1 : 0
          @diplomats += t.diplomats

          t.spynets = t.spynets ? 1 : 0
          @spynets += t.diplomats

          t.skilled_spacers = t.skilled_spacers ? 1 : 0
          @skilled_spacers += t.skilled_spacers

          # p t
          
          @tokens << t
          # p @tokens
        end

        haml :status
      end
    end
  end

  register Engine
end
