class Name < ActiveRecord::Base
  # make sure it's got that orf position at end
  VALID_CONTIG_NAME_REGEX = 
    /.+_\d+_\d+_\d+/

  validates :contig_name, presence: true, format: { with: VALID_CONTIG_NAME_REGEX }
  validates :orf_name, presence: true
end
