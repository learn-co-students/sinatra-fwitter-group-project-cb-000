class TweetsController < ApplicationController


    get '/tweets/new' do  #load the create tweet form
      erb :new
    end

    post '/tweets' do #process the form submission
      erb :tweets
    end

    get '/tweets/:id' do  #show a single tween
      erb :id
    end

    get '/tweets/:id/edit' do #load the edit a tweet page
      erb :edit
    end

    post '/tweets/:id' do #submit the edit form
      erb :id
    end

    post 'tweets/:id/delete' do
     erb :delete 
    end


end
