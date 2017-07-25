class TweetsController < ApplicationController


  get '/tweets'do
    if logged_in?(session)
      erb :'/tweets/index'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new'do
      if logged_in?(session)
        erb :'tweets/new'
      else
        redirect to "/login"
    end
  end

   get'/tweets/:id'do
    if logged_in?(session)
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit'do
      if logged_in?(session)
         @tweet = Tweet.find_by_id(params[:id])
         erb :"/tweets/edit"
       else
         redirect to "/login"
       end
  end

  post '/tweets'do
      if logged_in?(session)
        if params[:content].empty?
          redirect to "tweets/new"
        else
          @user = User.find_by_id(session[:user_id])
          tweet = Tweet.create(content: params[:content])
          @user.tweets << tweet
          @user.save
          redirect to "/users/#{@user.id}"
        end
      else
        redirect to "/login"
      end
  end

post "/tweets/:id"do
  @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets"
    end
end


post "/tweets/:id/delete"do
    @user = User.find_by_id(session[:user_id])
     @tweet = Tweet.find_by_id(params[:id])
     if @tweet.user_id == @user.id
     @tweet.destroy
     redirect to "/tweets"
   else
     redirect to "/tweets"
   end
end



end
