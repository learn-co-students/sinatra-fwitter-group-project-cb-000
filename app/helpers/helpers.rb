class Helpers

  def self.current_user(session)
    if !session[:user_id].nil?
      User.find_by_id(session[:user_id])
    end
  end

  def self.logged_in?(session)
    # check if session[:user_id] == nil, return true if logged in, underwise, return false
    # if session[:user_id] == nil
    #    false
    #  else
    #    true
    #  end
    !!session[:user_id]
  end

end
