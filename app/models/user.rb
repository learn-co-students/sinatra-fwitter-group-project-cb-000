class User < ActiveRecord::Base

  include Slug
  extend FindBySlug

  has_many :tweets
end
