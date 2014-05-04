require 'spec_helper'

describe "NeighborhoodPages" do

  subject { page }

  describe 'upload page' do
    before { visit upload_path }

    let(:submit) { 'Submit' }

    describe 'with invalid info' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(Collapse, :count)
      end
    end

    describe 'with valid info' do
      before do
        fill_in 'New name', with: 'DNA_POL_FAMILY'
        fill_in 'Old name', with: 'dna_pol_a'
      end

      it 'should create a new collapse entry' do
        expect { click_button submit }.to change(Collapse, :count).by 1
      end

    it { should have_content 'Upload' }
    it { should have_title(full_title 'Upload') }
    
    end
  end
end
