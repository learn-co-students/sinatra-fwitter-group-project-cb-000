require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/layout'
  end

  get '/login' do
    erb :'/login'
  end

  get '/signup' do
    erb :'/signup'
  end

  post '/signup' do
    params.each do |key, value|
      redirect '/signup' if value.empty?
    end

    user = User.create(username: params[:username], email: params[:email], password: params[:password])

    erb :'/twitter/tweets'

  end


end
