require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    # not quite sure what it means
    erb :signup
    # redirect '/tweets'
  end

  post '/signup' do

    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

    if user.save
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/signup"
    end
    # erb :signup
    # redirect '/tweets'
  end

end
