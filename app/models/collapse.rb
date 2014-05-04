class Collapse < ActiveRecord::Base
  validates :new_name, presence: true
  validates :old_name, presence: true, uniqueness: true

end
