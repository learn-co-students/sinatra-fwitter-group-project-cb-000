require './config/environment'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sooper-dooper-secret-930022"
  end

  get '/' do
    if !!session[:user_id]
      redirect '/tweets'
    else
      erb :index
    end
  end

end
