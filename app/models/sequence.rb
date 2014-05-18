class Sequence < ActiveRecord::Base
  has_many :superfamily_interactions
  has_many :orf_infos

  validates :contig, presence: true
  validates :header, presence: true, uniqueness: true

  # def get_associated_orfs
  #   OrfInfo.where(contig: @header)
  # end

end
