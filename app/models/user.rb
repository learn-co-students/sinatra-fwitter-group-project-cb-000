class User < ActiveRecord::Base
  has_many :tweets
  
  validates_presence_of :email, :username

  has_secure_password

  def slug
    self.username.parameterize
  end

  def self.find_by_slug(slug)
    User.all.find do |user| 
      user.slug == slug
    end
  end
end

