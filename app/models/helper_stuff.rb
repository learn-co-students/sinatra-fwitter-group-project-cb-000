#!/usr/bin/env ruby

module HelperStuff

  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def slug
      self.username.downcase.gsub ' ', '-'
    end
  end

  module ClassMethods
    def find_by_slug(input)
      self.all.detect {|a| a.slug == input}
    end
  end

end
