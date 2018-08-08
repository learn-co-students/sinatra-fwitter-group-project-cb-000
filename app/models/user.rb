class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  def slug
    slugify = username.gsub(/\s+/m, '-')
    slugify
  end

end
