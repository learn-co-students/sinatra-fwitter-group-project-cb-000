require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    use Rack::Flash
    set :session_secret, "fwitter password_security"
  end

  # GET - / - renders an index.erb file with links to signup or login or tweets action
  get '/' do
    erb :index
  end

  # handle 404 errors
  not_found do
    flash[:message] = "Page not found"
    if logged_in?
      redirect :"/tweets"
    else
      redirect :"/login"
    end
  end

end
