require 'spec_helper'

describe Sequence do
    before { @sequence = 
    Sequence.new(sequence: 'ACTGACGTACTGCACATACGGCATGATCGATCG',
                 header: 'my_funny_contig') }

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
