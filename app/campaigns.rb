require 'sinatra/base'
require_relative '../app/models/user'

module Sinatra
  module Campaigns

    def self.registered(app)

      app.get '/campaigns' do
        current_user.campaigns

        haml :'campaigns/list'
      end

      app.get '/campaign/new' do
        haml :'campaigns/new'
      end


    end
  end

  register Campaigns
end
