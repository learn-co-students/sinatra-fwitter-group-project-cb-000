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
      redirect '/users/login'
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

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets/new' do
    binding.pry
    erb :'tweets/new'
  end

  get '/users/:username' do
    # binding.pry
    @user = User.find_by_slug(params[:username])
    erb :'users/show'
  end

  delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end


end
