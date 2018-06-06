module Slugifiable
  module InstanceMethods
    def slug
      self.username.gsub(" ","-").downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |inst| inst.slug == slug }
    end
  end
end
