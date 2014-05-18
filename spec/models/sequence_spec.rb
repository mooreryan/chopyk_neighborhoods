require 'spec_helper'

describe Sequence do
  before do 
    @sequence = 
      Sequence.create!(contig: 'ACTGACGTACTGCACATACGGCATGATCGATCG',
                       header: 'my_funny_contig')

    OrfInfo.create!(name: 'orf_23_452_1', superfam: 'applase', 
                    contig: 'my_funny_contig')
    OrfInfo.create!(name: 'orf_500_782_2', superfam: 'bobase', 
                    contig: 'my_funny_contig')

  end
  
  # describe '.get_associated_orfs' do
  #   it 'gets the orfs associated with the sequence' do
  #     p @sequence.header
  #     expect(@sequence.get_associated_orfs).to eq OrfInfo.where(contig: @sequence.header)
  #   end
  # end


  subject { @sequence }

  it { should respond_to(:sequence) }
  it { should respond_to(:header) }

  it { should be_valid }

  describe 'when sequence is not present' do
    before { @sequence.sequence = '' }
    it { should_not be_valid }
  end

  describe 'when header is not present' do
    before { @sequence.header = '' }
    it { should_not be_valid }
  end

  describe "when header is already taken" do
    before do
      sequence_with_same_header = @sequence.dup
      sequence_with_same_header.save
    end

    it { should_not be_valid }
  end

end
