require './config/environment'

class ApplicationController < Sinatra::Base



  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/tweets' do
    # binding.pry
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/' do
    erb :index
  end


end
