require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions
  set :session_secret, "secret"

  get '/' do
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
