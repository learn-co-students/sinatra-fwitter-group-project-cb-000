
class Tweet < ActiveRecord::Base #inherits from activerecord (basically give it a bunch of other functionality in methods)
  belongs_to :user #this is an association. A tweet belongs to a user

end
