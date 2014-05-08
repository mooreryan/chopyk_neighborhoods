require 'spec_helper'

describe Interaction do
  before do 
    Interaction.create!(downstream: 'a', upstream: 'e', 
                        distance: 1, contig: 'seq1')
    Interaction.create!(downstream: 'a', upstream: 'e', 
                        distance: 0, contig: 'seq2')
    Interaction.create!(downstream: 'a', upstream: 'e', 
                        distance: 0, contig: 'seq3')
    Interaction.create!(downstream: 'a', upstream: 'b', 
                        distance: 0, contig: 'seq1')
    Interaction.create!(downstream: 'a', upstream: 'b', 
                        distance: 2, contig: 'seq4')
    Interaction.create!(downstream: 'c', upstream: 'd', 
                        distance: 2, contig: 'seq3')
    Interaction.create!(downstream: 'b', upstream: 'a', 
                        distance: 2, contig: 'seq5')

 
    Sequence.create! header: 'seq1', sequence: 'AAATCGACT'
    Sequence.create! header: 'seq2', sequence: 'GTGTTGAC'

    Collapse.create(new_name: 'DNA_POL_FAMILY',
                    old_name: 'dna_pol_a')
    Collapse.create(new_name: 'SILLY_FAMILY',
                    old_name: 'a')
    Collapse.create(new_name: 'SILLY_FAMILY',
                    old_name: 'g')
    Collapse.create(new_name: 'SASSY_FAMILY',
                    old_name: 'b')
    Collapse.create(new_name: 'SASSY_FAMILY',
                    old_name: 'c')
    
    @interaction = Interaction.first
  end

  describe 'collapsed_interactions' do 
    describe 'with collapse, and min number specified' do
      it 'returns the proper records' do
        collapsed = 
          Interaction.collapsed_interactions(collapse: 'SILLY_FAMILY',
                                             min: 2)
        # sassy_fam collapses 'e' to sassy_fam
        expect(collapsed).to(eq([[['SILLY_FAMILY', 'e'], 3], 
                                 [['SILLY_FAMILY', 'b'], 2]]))
      end      
    end

    describe 'with just the min number specified' do
      it 'returns the proper records' do
        collapsed = 
          Interaction.collapsed_interactions(min: 2)

        expect(collapsed).to(eq([[['a', 'e'], 3],
                                 [['a', 'b'], 2]]))
      end
    end
  end

  describe 'filter_contigs' do 
    it { pending 'needs to be tested' }
  end
  
  subject { @interaction }

  it { should respond_to :downstream }
  it { should respond_to :upstream }
  it { should respond_to :distance }
  it { should respond_to :contig }

  it { should be_valid }

  describe 'when downstream is not present' do
    before do 
      @interaction = Interaction.new(downstream: '', upstream: 'happy',
                                     distance: 45, contig: 'ACTGACG')
    end

    it { should_not be_valid }
  end

  describe 'when upstream is not present' do
    before do 
      @interaction = Interaction.new(downstream: 'happy', upstream: '',
                                     distance: 45, contig: 'ACTGACG')
    end
    
    it { should_not be_valid }
  end

  describe 'when distance is not present' do
    before do 
      @interaction = Interaction.new(downstream: 'apple', upstream: 'pie',
                                     distance: nil, contig: 'AAATG')
    end
    
    it { should_not be_valid }
  end


  describe 'when contig is not present' do
    before do 
      @interaction = Interaction.new(downstream: 'apple', upstream: 'pie',
                                     distance: 45, contig: '')
    end
    
    it { should_not be_valid }
  end

  # see http://goo.gl/UsRkUX for more info on this
  pending('downstream, upstream, distance, contig should be unique ' +
          'when taken together')


end
