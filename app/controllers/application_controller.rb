require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions
  set :session_secret, "secret"

  get '/' do
    redirect to "/home" if session[:digest]
    erb :index
  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

  helpers do
    def sessionAuth(session)
      User.find_by(:password_digest => session[:digest])
    end
  end

end
