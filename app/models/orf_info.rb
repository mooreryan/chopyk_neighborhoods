class OrfInfo < ActiveRecord::Base
  belongs_to :sequence

  # TODO test
  # def get_start_length
  #   coords = @name.match(/_\d+_\d+_\d+$/).to_s.split('_')[1..2]
  #     .map { |s| s.to_i }.sort.reverse

  #   { start: coords.last, length: coords.reduce(:-) + 1 }
  # end


end
