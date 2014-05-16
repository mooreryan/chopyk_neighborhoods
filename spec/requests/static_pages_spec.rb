require 'spec_helper'

describe "Static pages" do

  subject { page }

  it 'should have the right links on the layout' do 
    visit root_path
    
    click_link 'About'
    expect(page).to have_title(full_title('About'))
    
    click_link 'Help'
    expect(page).to have_title(full_title('Help'))

    click_link 'Contact'
    expect(page).to have_title(full_title('Contact'))

    click_link 'ChopBot 3000'
    expect(page).to have_title(full_title(''))

    # check the other way to get home
    click_link 'About'
    expect(page).to have_title(full_title(''))

    click_link 'Upload'
    expect(page).to have_title(full_title('Upload'))

    click_link 'Search'
    expect(page).to have_title(full_title('Search'))

    click_link 'Neighbors'
    expect(page).to have_title(full_title('Neighbors'))

    click_link 'Superfamilies'
    expect(page).to have_title(full_title('Superfamilies'))


    # TODO: figure out how to check external links
    # click_link 'Google'
    # expect(page).to have_title('Google')
  end

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'ChopBot 3000' }
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'

    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like 'all static pages'
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end
end
