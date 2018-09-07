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
    # params.each do |key, value|
    #   redirect '/signup' if value.empty?
    # end

    params.each do |key, value|
      value.empty? ? (redirect '/signup') : (key = value)
    end

    binding.pry
    erb :'/twitter/index'
  end


end
