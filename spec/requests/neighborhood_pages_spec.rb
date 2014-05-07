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

  describe 'neighborhood search page' do
    before do 
      create_interaction_entries
      create_sequence_entries
      visit search_path
    end
    
    let(:search) { 'Search' }

    describe 'it responds to multiple things' do
      it 'responds to .txt format' do
        pending 'Test that it responds to .txt format'
      end
    end

    describe 'when you first get to the page' do
      it "shouldn't display no matches message" do
        page.should_not have_content 'No matches!'
      end
    end

    describe 'with matching query' do
      before do
        # fill_in 'Downstream', with: 'a'
        # fill_in 'Upstream', with: 'e'
        select 'a', from: 'Downstream'
        select 'e', from: 'Upstream'
      end

      it 'it should have a table with the matching data' do
        click_button search
        page.should have_content 'seq1'
        page.should have_content 'seq2'
      end
    end

    describe "with query that doesn't match" do
      before do
        # fill_in 'Downstream', with: 'apple'
        # fill_in 'Upstream',   with: 'pie'
        select 'd', from: 'Downstream'
        select 'a', from: 'Upstream'
      end

      it "shouldn't have any info in the table" do
        click_button search
        page.should have_content 'No matches!'

      end

    end
    
    it { should have_content 'Search' }
    it { should have_title(full_title 'Search') }
  end
end
