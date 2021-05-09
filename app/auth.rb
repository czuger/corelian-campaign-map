require 'sinatra/base'
require_relative '../app/models/user'

module Sinatra
  module Auth

    module Helpers
      def authorized?
        !session[:user_id].nil?
      end

      def authorize!
        redirect '/login' unless authorized?
      end

      def logout!
        session[:user_id] = nil
      end

      def register_user(auth_hash)
        u = User.first_or_initialize(uid: auth_hash['uid'])
        u.name = auth_hash['info']['name']
        u.avatar = auth_hash['info']['image']
        u.save!

        session[:user_id] = u.id
        p session
      end

      def current_user
        User.find(session[:user_id])
      end
    end

    def self.registered(app)
      app.helpers Auth::Helpers

      app.get '/login' do
        # p session.loaded?
        # session[:init] = true
        # p session.loaded?
        #
        # p session

        @session_failure = session['crfs_failed']

        p request.env['rack.session']

        haml :login
      end

      app.get '/auth/:provider/callback' do
        register_user(request.env['omniauth.auth'])
        session['crfs_failed'] = false
        redirect '/'
      end

      app.get '/auth/failure' do
        if !session.loaded?
          session['crfs_failed'] = true
          redirect '/login'
        else
          erb "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
        end
      end

      app.get '/auth/:provider/deauthorized' do
        erb "#{params[:provider]} has deauthorized this app."
      end

      app.get '/protected' do
        throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
        erb "<pre>#{request.env['omniauth.auth'].to_json}</pre><hr>
         <a href='/logout'>Logout</a>"
      end

      app.get '/logout' do
        logout!
        redirect '/'
      end
    end
  end

  register Auth
end
