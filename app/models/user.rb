class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  # validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates :email, uniqueness: true
  validates :password_digest, presence: true


  def slug
   # not sure why self.name is better than @name here
   self.username.downcase.gsub(/\s/, '-')
 end
end
