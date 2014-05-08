require 'spec_helper'

describe Collapse do
  before do
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

    @collapse = Collapse.first
  end
  
  describe 'unique_families' do
    it 'lists all the new_names in the database' do
      families = Collapse.unique_families
      expect(families).to eq %w[DNA_POL_FAMILY SILLY_FAMILY SASSY_FAMILY]
    end
  end

  describe 'family map' do
    it 'gives a map of families' do
      family_map = { 
        DNA_POL_FAMILY: ['dna_pol_a'],
        SILLY_FAMILY: %w[a g],
        SASSY_FAMILY: %w[b c] }
      expect(Collapse.family_map).to eq family_map
    end
  end

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
      @num_before_test = Collapse.all.length
      collapse_with_same_old_name = @collapse.dup
      collapse_with_same_old_name.save
    end

    it "it won't add an entry" do
      expect(Collapse.all.length).to eq @num_before_test
    end
  end
end
