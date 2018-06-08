require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  enable :sessions
  set :session_secret, "secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def current_user
      User.find_by(:password_digest = session[:digest])
    end

    def logged_in?
      session.key?(:digest)
    end
  end

end
