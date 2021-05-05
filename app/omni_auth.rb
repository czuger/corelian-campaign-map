require 'sinatra/base'

module Sinatra
  module OmniAuth

    def self.registered(app)
      app.get '/' do
        erb "
    <a href='http://localhost:4567/auth/github'>Login with Github</a><br>
    <a href='http://localhost:4567/auth/facebook'>Login with facebook</a><br>
    <a href='http://localhost:4567/auth/twitter'>Login with twitter</a><br>
    <a href='http://localhost:4567/auth/att-foundry'>Login with att-foundry</a>"
      end

      app.get '/auth/:provider/callback' do
        erb "<h1>#{params[:provider]}</h1>
         <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
      end

      app.get '/auth/failure' do
        erb "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
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
        session[:authenticated] = false
        redirect '/'
      end
    end
  end

  register OmniAuth
end
