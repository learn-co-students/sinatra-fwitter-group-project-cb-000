class TweetsController < ApplicationController
  get '/:slug/tweets' do
    erb :'tweets/tweets'
  end
end
