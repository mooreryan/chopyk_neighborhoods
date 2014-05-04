require 'spec_helper'

describe Collapse do
  before { @collapse = 
    Collapse.new(new_name: 'DNA_POL_FAMILY',
                 old_name: 'dna_pol_a') }

  subject { @collapse }

  it { should respond_to(:new_name) }
  it { should respond_to(:old_name) }

  it { should be_valid }

  describe 'when new_name is not present' do
    before { @collapse.new_name = '' }
    it { should_not be_valid }
  end

  describe 'when old_name is not present' do
    before { @collapse.old_name = '' }
    it { should_not be_valid }
  end

  describe "when old_name is already taken" do
    before do
      collapse_with_same_old_name = @collapse.dup
      collapse_with_same_old_name.save
    end

    it { should_not be_valid }
  end

end
