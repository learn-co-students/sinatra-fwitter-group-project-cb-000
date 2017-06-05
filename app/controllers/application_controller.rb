require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::Reloader

   configure do
     enable :session
     set :session_secret, "my_application_secret"
  set :public_folder , Proc.new {File.join(root,"../public")}
    set :views, 'app/views'
  end



  get '/'do

    erb :index
  end


  get '/signup'do
      if logged_in?
        redirect to "/users/tweets"
      else

    erb :'/users/new'
  end
  end

  post '/signup'do

     if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?


redirect to "/users/tweets"
     else
       redirect to "/signup"
     end


  end


  helpers do

    def logged_in?
        !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
  end
end
