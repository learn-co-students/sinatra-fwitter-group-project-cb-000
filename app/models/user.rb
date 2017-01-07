class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets

  #user needs slug method to name-stuff
  def slug
    self.username.gsub(' ', '-').downcase
  end

  def self.find_by_slug(slug)
    self.all.find{|i| i.slug == slug}
  end

end
