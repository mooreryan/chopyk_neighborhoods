require 'spec_helper'

describe Name do
  before { @name = 
    Name.new(contig_name: '9W6_11200094_94_1_1', 
             orf_name: 'Efflux transporter, RND family, MFP subunit') }

  subject { @name }

  it { should respond_to(:contig_name) }
  it { should respond_to(:orf_name) }

  it { should be_valid }

  describe 'when contig_name is not present' do
    before { @name.contig_name = '' }
    it { should_not be_valid }
  end

  describe 'when orf_name is not present' do
    before { @name.orf_name = '' }
    it { should_not be_valid }
  end

  describe 'when contig_name format is invalid' do
    it 'should be invalid' do
      contig_names = %w[apple apple_pie apple_pie_54 1_34_98 
                        contig243_238b_2d_3 contig243_238b_2d_3 _1_2_3]
      contig_names.each do |bad_name|
        @name.contig_name = bad_name
        expect(@name).not_to be_valid
      end
    end
  end

  describe 'when contig_name format is valid' do
    it 'should be valid' do
      contig_names = %w[apple_1_2_3 pie_238_32_9_823 1_23_32_982389 
                       yummy_apple_pie_1_2_3]
      contig_names.each do |good_name|
        @name.contig_name = good_name
        expect(@name).to be_valid
      end
    end
  end      
end
