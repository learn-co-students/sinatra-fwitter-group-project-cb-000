class Tweet < ActiveRecord::Base
  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods
  validates :content, length: {minimum: 1, message: "Content cannot be empty"}

  belongs_to :user

end
