class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    erb :'/show_tweet'
  end


end
