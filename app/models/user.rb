class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    @username = self.username
    @username.gsub " ", "-"
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
       if user.slug == slug
         return user
       end
    end
  end

end
