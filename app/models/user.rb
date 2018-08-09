class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password

  before_save do |user|
    self.username.downcase!
    self.email.downcase!
  end

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.find { |user| user.slug == slug }
  end
end
