require './config/environment'

class ApplicationController < Sinatra::Base



  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/tweets' do
    # binding.pry
    if(session[:user_id] != nil)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if session[:user_id] == nil
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    # binding.pry
    if(session[:user_id] != nil)
      session[:user_id] = nil
      redirect 'users/login'
    else
      redirect '/'
    end

  end

end
