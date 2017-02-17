class User < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  has_secure_password
  validates :username, presence: true
  validates :email, presence: true
  has_many :tweets
end
