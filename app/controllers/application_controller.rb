require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, "secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

end
