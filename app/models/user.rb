class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def self.invalid_params(p)
    p[:username].empty? || 
    p[:email].empty? || 
    p[:password].empty?
  end

  def self.find_by_slug(slug)
    self.find_by(username: slug.gsub(/[-]/," "))
  end

  def slug
    self.username.gsub(/\s/,"-")
  end  
end
