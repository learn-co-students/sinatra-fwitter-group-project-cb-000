require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::Reloader

   configure do
     enable :sessions
     set :session_secret, "my_application_secret"
  set :public_folder , Proc.new {File.join(root,"../public")}
    set :views, 'app/views'
  end



  get '/'do

    erb :'/home/index'
  end

  get '/tweets'do
  if logged_in?(session)
    erb :'/tweets/index'
  else
    redirect to "/login"
  end
  end

  get '/signup'do

      if logged_in?(session)
        puts "HELLO one whose logged in"
        redirect to '/tweets'
      else
        puts "Hello one whose not logged in"
        erb :'/users/create_user'
      end
  end

  get '/login'do
      if logged_in?(session)
        redirect to "/tweets"
      else
     erb :'/users/login'
   end
  end

  get '/logout'do
    if logged_in?(session)
     session.clear
       redirect to "/login"

     elsif !logged_in?(session)

       redirect to "/login"
     elseif
     end

   end

get '/users/:id'do
    @user = User.find_by_id(params[:id])
    erb :"/users/show"
end

get '/tweets/new'do
    if logged_in?(session)
    erb :'tweets/new'
  else
    redirect to "/login"
  end
end

 get'/tweets/:id'do

 @user = User.find_by_id(session[:user_id])
  @tweet = Tweet.find_by_id(params[:id])
  erb :"tweets/show"
end
##########################################################################
  post '/login'do

     @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
         redirect to "/tweets"
     else
       redirect to "/login"
     end


  end



  post '/signup'do

     if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?

        @user = User.create(username: params[:username], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        session[:user_id] = @user.id
        redirect to "/tweets/index"
     else
       redirect to "/signup"
     end


  end

  post '/tweets'do
      if logged_in?(session)
        if params[:content].empty?
          redirect to "tweets/new"
        else
          @user = User.find_by_id(session[:user_id])
          tweet = Tweet.create(content: params[:content])
          @user.tweets << tweet
          @user.save
          redirect to "/users/#{@user.id}"
        end
      else
        redirect to "/login"
      end
end

post "/tweets/:id"do
      @tweet = Tweet.find_by_id(params[:id])
      redirect to "/tweets"
end


post "/tweets/:id/delete"do
     @tweet = Tweet.find_by_id(params[:id])
     @tweet.destroy
     redirect to "/tweets"
end


  helpers do

    def logged_in?(session)
        !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end
end
