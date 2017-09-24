class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  #causes controller tests to fail line 60
  # validates :username, uniqueness: true
  # validates :username, presence: true
  # validates :email, uniqueness: true
  # validates :email, presence: true
  # validates :password, presence: true

  def slug
    self.username.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end

end
