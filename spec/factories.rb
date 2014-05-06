FactoryGirl.define do
  factory :interaction do
    downstream 'a'
    upstream   'e'
    distance   1
    contig     'seq1'
  end

  # factory :sequence do
  #   header   'seq1'
  #   sequence 'ATCGATCGAGTCATCGATGCATCGTACGATCGAC'
  # end
end
