module Slugifiable
  module InstanceMethods
    def slug
      self.username.gsub(/\W/, "-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find do |instance|
        instance.slug == slug
      end
    end
  end
end
