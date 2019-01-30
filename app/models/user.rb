class User < ActiveRecord::Base
  include Slugifiable
  extend Slugifiable::Find

  has_secure_password
  has_many :posts

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

end
