class Helpers

  def self.current_user(session)
    @user = User.find(session[:user_id])
    @user
  end


  def self.logged_in?(session)
    session[:user_id] != nil
  end


end
