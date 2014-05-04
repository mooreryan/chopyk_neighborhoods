class Sequence < ActiveRecord::Base
  validates :sequence, presence: true
  validates :header, presence: true, uniqueness: true

end
