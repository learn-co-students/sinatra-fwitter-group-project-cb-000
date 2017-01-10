class User < ActiveRecord::Base
  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true
  has_secure_password

  has_many :tweets

  def has_tweet?(tweet)
    self.tweets.include?(tweet)
  end

  def to_s
    self.username
  end


end
