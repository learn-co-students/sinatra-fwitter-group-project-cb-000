require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #unless test?
    set :session_secret, "189f6bcf57996691dcde64cc582fd1c82b20f7c0e11f0ad0ba404c3523cc7fac12a20b3cd446b29800c3c174ce8deb7db8f5c05918f5dabbbb67dfd45eb70e59"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

end
