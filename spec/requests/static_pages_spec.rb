require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Chopyk Neighborhoods" }

  describe "Home page" do

    it "should have the content 'Chopyk Neighborhoods'" do
      visit '/static_pages/home'
      expect(page).to have_content('Chopyk Neighborhoods')
    end

    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe 'Help page' do 

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    it "should have the right title" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe 'About page' do 

    it "should have the content 'About'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
    it "should have the right title" do
      visit '/static_pages/about'
      expect(page).to have_title("#{base_title} | About")
    end

  end
end
