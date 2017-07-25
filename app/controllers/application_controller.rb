require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    end
    redirect '/'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'tweets/edit'
      else
        flash[:message] = "You can not edit another user's tweet!"
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content] != ""
      tweet.update(params[:tweet])
      redirect "/tweets/#{tweet.id}"
    else
      flash[:message] = "Tweets can't be left blank."
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.user_id == session[:user_id]
      tweet.delete
      redirect '/tweets'
    else
      flash[:message] = "You can not delete someone else's tweet!"
      redirect "/tweets/#{tweet.id}"
    end
  end

  post '/signup' do
    if params[:user][:password] == params[:password_validation]
      user = User.new(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect '/tweets'
      else
        errors = ""
        params[:user].each do |key, value|
          if value == ""
            errors += "#{key}  "
          end
        end
        flash[:message] = "Invalid #{errors}  "
        redirect '/signup'
      end
    else
      flash[:message] = "Passwords Did Not Match"
      redirect '/signup'
    end
  end

  post '/tweets' do
    if params[:tweet][:content] != ""
      user = Helpers.current_user(session)
      user.tweets.build(params[:tweet])
      user.save
      redirect "/users/#{user.slug}"
    else
      flash[:message] = "You can't Tweet that!"
      redirect '/tweets/new'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:message] = "Incorrect Username and/or Password"
      redirect '/login'
    end
  end

end
