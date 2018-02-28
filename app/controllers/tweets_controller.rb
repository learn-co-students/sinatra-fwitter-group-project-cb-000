class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in? #if logged in
      @tweets = Tweet.all #show all users tweets
      erb :'tweets/tweets'
    else
      redirect to '/login' #othwerwise redirect to login
    end
  end

    get '/tweets/new' do  #load the new tweet form
      if logged_in?
     erb :'tweets/new_tweet'
   else
     redirect to '/login' #if not logged in redirect to login
   end
 end

    post '/tweets' do #process the form submission
      if params[:content] == "" #if content is empty redirect to new tweet path
      redirect to "/tweets/new"
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect to "/tweets/#{@tweet.id}" #otherwise create new tweet
    end
  end

    get '/tweets/:id' do  #show a single tweet
      if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  else
    redirect to '/login' #unless not logged in then redirect
  end
end

    get '/tweets/:id/edit' do #load the edit a tweet page
      if logged_in?
  @tweet = Tweet.find_by_id(params[:id])
  if @tweet.user_id == current_user.id #if the user id and the current user id match then
   erb :'tweets/edit_tweet' #allow user to edit tweet
  else
    redirect to '/tweets' #otherwise redirect back to tweets
  end
else
  redirect to '/login' #if not logged in redirect
end
end

    patch '/tweets/:id' do #submit edit tweet form
      if params[:content] == "" #if content is empty
        redirect to "/tweets/#{params[:id]}/edit" #then redirect back to edit
      else
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save #otherwise save the updated/edited tweet
        redirect to "/tweets/#{@tweet.id}"
      end
    end


    delete '/tweets/:id/delete' do #delete tweet
      if logged_in? #if logged in
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id #and user_id matches as author of tweet
          @tweet.delete #then delete the tweet
          redirect to '/tweets'
        else
          redirect to '/tweets' #otherwise redirect without deleting
        end
      else
        redirect to '/login' #if not logged in reditect
      end
    end
  end
