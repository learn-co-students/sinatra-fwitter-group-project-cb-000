class User < ActiveRecord::Base #inherits from activerecord (basically give it a bunch of other functionality in methods)
  has_many :tweets #this is an association. A user has many tweets


    has_secure_password

    def slug # a slug is used to allow for the url path to not need dashes-between-words-and-replaces them with space
      username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
      User.all.find{|user| user.slug == slug}
    end

  end
