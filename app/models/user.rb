class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  validates_presence_of :username, :email

  def slug
    username.gsub(/ +/, '-').downcase
  end

  def self.find_by_slug(slug)
    deslugify = slug.gsub('-', ' ')
    where("lower(username) = ?", deslugify).first
  end
end
