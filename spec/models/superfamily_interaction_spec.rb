require 'spec_helper'

describe SuperfamilyInteraction do
  before do 
    SuperfamilyInteraction.create!(downstream: 'a', upstream: 'e', 
                                   distance: 1, contig: 'seq1')
    SuperfamilyInteraction.create!(downstream: 'a', upstream: 'e', 
                                   distance: 0, contig: 'seq2')
    SuperfamilyInteraction.create!(downstream: 'a', upstream: 'e', 
                                   distance: 0, contig: 'seq3')
    SuperfamilyInteraction.create!(downstream: 'a', upstream: 'b', 
                                   distance: 0, contig: 'seq1')
    SuperfamilyInteraction.create!(downstream: 'a', upstream: 'b', 
                                   distance: 2, contig: 'seq4')
    SuperfamilyInteraction.create!(downstream: 'c', upstream: 'd', 
                                   distance: 2, contig: 'seq3')
    SuperfamilyInteraction.create!(downstream: 'b', upstream: 'a', 
                                   distance: 2, contig: 'seq5')

 
    Sequence.create!( header: 'seq1', contig: 'AAATCGACT' )
    Sequence.create!( header: 'seq2', contig: 'GTGTTGAC' )
    Sequence.create!( header: 'seq4', contig: 'TTTTT' )
  end

  # TODO fix this
  describe 'filter_contigs' do
    it 'gets contigs from associations' do
      down, up = 'a', 'b'
      contigs = SuperfamilyInteraction.filter_contigs(down, up)
      expected_val = [">downstream=a_upstream=b_contig=seq1\nAAATCGACT",
                      ">downstream=a_upstream=b_contig=seq4\nTTTTT" ]
      expect(contigs).to eq expected_val
    end
  end
end
