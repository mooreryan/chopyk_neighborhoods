require 'spec_helper'

describe Interaction do
  before do 
    Interaction.create!(downstream: 'a', upstream: 'e', 
                        distance: 1, contig: 'seq1')
    Interaction.create!(downstream: 'a', upstream: 'b', 
                        distance: 0, contig: 'seq1')
    Interaction.create!(downstream: 'a', upstream: 'e', 
                        distance: 0, contig: 'seq2')
 
    Sequence.create! header: 'seq1', sequence: 'AAATCGACT'
    Sequence.create! header: 'seq2', sequence: 'GTGTTGAC'
    
    @interaction = Interaction.first
  end

  describe 'filter contigs' do
    describe 'with successful search' do
      it 'should return the right number of records' do
        filtered_contigs = Interaction.filter_contigs 'a', 'e'
        expect(filtered_contigs.length).to be 2
      end
    end

    describe 'with failing search' do
      it 'should return an empty thing' do
        filtered_contigs = Interaction.filter_contigs 'a', 'q'
        expect(filtered_contigs.length).to be 0
      end
    end
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
