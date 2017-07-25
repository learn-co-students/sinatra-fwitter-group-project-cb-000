class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.detect{|user| user.slug == slug}
  end

  def invalid_params?(params)
    blanks = []
    params.each do |key,value|
      blanks << key.to_string 
    end
  end
end