class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  def slug
    downcased_name = self.username.downcase
    downcased_name.gsub(/\s+/, '-')
  end
  
  def self.find_by_slug(slug)
    split_slug = slug.split("-")
    word = split_slug.join(" ")
    self.all.each do |user|
      if user.username == word
        return user
      end
    end
  end
end
