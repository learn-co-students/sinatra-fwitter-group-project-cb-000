class User < ActiveRecord::Base
  include Slug
  extend FindBySlug

  has_secure_password

  has_many :tweets
end
