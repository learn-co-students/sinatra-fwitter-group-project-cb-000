module Slugifiable
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  module Find
    def find_by_slug(data)
      self.all.find { |name| name.slug == data }
    end
  end
end
