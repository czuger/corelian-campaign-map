require 'sinatra/base'

module Sinatra
  module Engine

    EMPIRE_CYCLE = %w(empire_base destroyed diplomat empty)
    REBEL_CYCLE = %w(rebel_base rebel_outpost destroyed empty)
    REBEL_HIDDEN = %w(rebel_base rebel_outpost)

    PICS_CONVERT = {
      'empire_base': 'pics/ImperialBase_sticker.png',
      'rebel_base': 'pics/RebelBase_sticker.png',
      'rebel_outpost': 'pics/RebelOutpost_sticker.png',
      'destroyed': 'pics/PresenceDestroyed_sticker.png',
      'diplomat': 'pics/StratEff_Diplomat.png',
      rebel_presence: 'pics/PresenceDestroyed_sticker.png'
    }

    def icons_hash
      if current_player.side == 'empire'
        { cycle: EMPIRE_CYCLE, pics_convert: PICS_CONVERT }
      elsif current_player.side == 'rebel'
        { cycle: REBEL_CYCLE, pics_convert: PICS_CONVERT }
      else
        { cycle: [], pics_convert: PICS_CONVERT }
      end
    end

    def self.registered(app)

      app.get '/map/:campaign_id' do
        @campaign = Campaign.find(params['campaign_id'])

        return_hash = icons_hash
        return_hash[:tokens] = @campaign.tokens.all.to_a

        if current_player.side != 'rebel'
          return_hash[:tokens].map!{ |e| REBEL_HIDDEN.include?(e) ? :rebel_presence : e }
        end

        return_hash
      end

      app.post '/map/:campaign_id/set_position/:location/:token' do
        @campaign = Campaign.find(params['campaign_id'])
        location = params['location']
        token = params['token']

        if token == 'empty'
          @campaign.tokens.where(location: location).delete_all
        else
          db_token = @campaign.tokens.where(location: location).first_or_initialize{ |t|
            t.status = token
          }
          db_token.save!
        end
      end
    end
  end

  register Engine
end
