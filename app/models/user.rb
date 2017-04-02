class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
   has_secure_password
   has_many :tweets
   validates :username, presence: true
   validates :email, presence: true
end
