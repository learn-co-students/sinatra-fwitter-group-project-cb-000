class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email
  has_secure_password

  def slug
    self.username.gsub(/\W/, '-').downcase
  end

  def self.find_by_slug(slug)
    self.all.select do |instance|
      instance if instance.slug == slug
    end.first
  end
end
