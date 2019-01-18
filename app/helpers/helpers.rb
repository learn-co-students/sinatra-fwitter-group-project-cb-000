class Helpers
  def self.current_user(sesh)
    user_id = sesh[:user_id]
    user = User.find_by(id: sesh[:user_id])
    user
  end
  def self.is_logged_in?(sesh)
    !!current_user(sesh)
  end
end
