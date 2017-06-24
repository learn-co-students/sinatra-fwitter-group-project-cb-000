class Helpers
  def self.current_user(args)
    User.find_by(id: args[:user_id])
  end

  def self.is_logged_in?(args)
    !!self.current_user(args)
  end
end
