require 'sinatra/base'

module Sinatra
  module Engine

    # app.get '/' do
    #   campaign = app.get_campaign('public_key', params['key'])
    #   if campaign
    #     tokens = campaign.tokens.all
    #
    #     result = []3+++++
    #     tokens.each do |e|
    #       result << { status: [2, 3].include?(e.status) ? 99 : e.status, location: e.location }
    #     end
    #
    #     return result.to_json
    #   else
    #     return 'Denied'
    #   end
    # end

    def get_campaign(access, key)
      Campaign.where(access => key).take()
    end

    def self.registered(app)
      app.get '/rebels_edit' do
        campaign = app.get_campaign('rebels_edit_key', params['key'])
        if campaign
          return campaign.tokens.all.to_json
        else
          return 'Denied'
        end
      end

      app.get '/rebels_edit' do
        campaign = app.get_campaign('rebels_edit_key', params['key'])
        if campaign
          return campaign.tokens.all.to_json
        else
          return 'Denied'
        end
      end

      app.get '/imperial' do
        campaign = app.get_campaign('imperial_status_key', params['key'])
        tokens = campaign.tokens.where(status: 1)
        tokens.to_a.to_json
      end

      app.get '/rebels' do
        campaign = app.get_campaign('rebels_status_key', params['key'])
        tokens = campaign.tokens.where(status: [2, 3])
        tokens.to_a.to_json
      end

      app.post '/add_position' do
        campaign = app.get_campaign('rebels_edit_key', params['key'])
        location = params['location']

        token = campaign.tokens.where(location: location).first_or_initialize{ |t|
          t.status = 1
        }
        token.save!

      end

      app.post '/modify_position' do
        campaign = app.get_campaign('rebels_edit_key', params['key'])
        location = params['location']
        status = params['status']

        # p location

        token = campaign.tokens.where(location: location).take
        token.status = status
        token.save!
      end

      app.post '/delete_position' do
        location = params['location']
        # status = params['status']

        # p location

        Token.where(location: location).delete_all
      end

      app.post '/new_campaign' do
        Campaign.create!(
            name: params['name'],
            public_key: SecureRandom.hex(12),
            rebels_edit_key: SecureRandom.hex(12),
            rebels_status_key: SecureRandom.hex(12),
            imperial_status_key: SecureRandom.hex(12)
        )

        return 'Ok'
      end

      app.get '/list_campaigns' do
        result = []
        host = settings['host']
        # random = SecureRandom.alphanumeric(12)

        Campaign.all.each do |c|
          result << {
              'campagne': c.name,
              'public': "#{host}/index.html?&key=#{c.public_key}",
              'rebels_edit': "#{host}/index.html?&key=#{c.rebels_edit_key}&rebels_edit=true",
              'rebels_status': "#{host}/status.html?&side=rebels&key=#{c.rebels_status_key}",
              'imperial_status': "#{host}/status.html?&side=imperial&key=#{c.imperial_status_key}"
          }
        end

        return result.to_json
      end
    end
  end

  register Engine
end
