class TweetsController < ApplicationController
    use Rack::MethodOverride

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all
            erb :"/tweets/tweets"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"tweets/create_tweet"
        else
            redirect "/login"
        end
    end

    post "/tweets/new" do
        if !params[:content].empty?
            tweet = Tweet.create(params)
            tweet.user = current_user
            tweet.save
            redirect "/tweets"
        else
            flash[:error] = "You can't create an empty tweet!"
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id" do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet
                @form_type = form_type
                erb :"/tweets/show_tweet"
            else
                "No Tweet Found."
            end
        else
            redirect "/login"
        end
    end

    delete "/tweets/:id/delete" do
        tweet = Tweet.find(params[:id])
        if eligible(tweet)
            tweet.delete
            redirect "/tweets"
        else
            flash[:error] = "You can't delete someone else's tweet!"
            redirect "/tweets/#{params[:id]}"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && eligible(@tweet)
            erb :"tweets/edit_tweet"
        else
            redirect "/login"
        end
    end

    patch "/tweets/:id/edit" do
        if !params[:content].empty?
            tweet = Tweet.find(params[:id])
            tweet.update(content: params[:content])
            redirect "/tweets"
        else    
            flash[:error] = "You can't create an empty tweet!"
            redirect "/tweets/#{params[:id]}/edit"
        end
    end
end