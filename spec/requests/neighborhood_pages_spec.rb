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
      # create the interaction entries
      File.open('spec/test_files/interactions.txt', 'r').each_line do |line|
        down, up, dist, cont = line.chomp.split("\t")

        Interaction.create(downstream: down, upstream: up, distance: dist, contig: cont)
      end
      
      # create the sequence entries
      File.open('spec/test_files/contigs.fasta', 'r').each(sep="\n>") do |line|
        header, sequence = line.chomp.split( "\n", 2 )
          .map { |x| x.gsub( /\n|>/, '' ) }
        
        Sequence.create(header: header, sequence: sequence)
      end
      
      visit search_path
    end
    
    let(:search) { 'Search' }

    describe 'with matching query' do
      before do
        fill_in 'Downstream', with: 'a'
        fill_in 'Upstream', with: 'e'
      end

      it 'it should have a table with the matching data' do
        click_button search
        page.should have_content 'seq1'
        page.should have_content 'seq2'
      end
    end

    describe "with query that doesn't match" do
      before do
        fill_in 'Downstream', with: 'apple'
        fill_in 'Upstream',   with: 'pie'
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
