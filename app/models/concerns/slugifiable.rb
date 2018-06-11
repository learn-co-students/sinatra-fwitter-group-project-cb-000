module Slugifiable
  module InstanceMethods
    def slug
      self.username.downcase.gsub(' ', '-')
    end
  end
  module ClassMethods
    def find_by_slug(slug)
      self.find_by(:slug => slug)
    end
  end
end
