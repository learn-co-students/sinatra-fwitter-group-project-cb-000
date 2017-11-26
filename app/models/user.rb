class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets

    def slug
        self.username.downcase.gsub(" ", "-").gsub(/\W/, "-")
    end

    def self.find_by_slug(slug)
        self.all.detect do |user|
            user.slug == slug
        end
    end
end