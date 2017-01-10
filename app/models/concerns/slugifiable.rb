module Concerns
  module Slugifiable
    module InstanceMethods
      def slug
        self.username.strip.downcase.gsub(/[[:punct:]]/, "").gsub(/\s/, "-")
      end
    end

    module ClassMethods
      def find_by_slug(slug)
        self.all.find {|instance| instance.slug == slug}
      end
    end
  end
end
