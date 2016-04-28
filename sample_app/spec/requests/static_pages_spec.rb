require 'rails_helper'

describe "StaticPages" do
  subject{ page }
  let(:title) { "Ruby on Rails Tutorial Sample App" }

  shared_examples "all_static_pages" do
    it { is_expected.to have_content(heading) }
    it { is_expected.to have_title(full_title(page_title)) }
  end
  
  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_behaves_like 'all_static_pages'
    it { is_expected.not_to have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_behaves_like 'all_static_pages'
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About' }

    it_behaves_like 'all_static_pages'
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_behaves_like 'all_static_pages'
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link 'About'
    is_expected.to have_title 'About'
    click_link 'Help'
    is_expected.to have_title 'Help'
    click_link 'Contact'
    is_expected.to have_title 'Contact'
    click_link 'Home'
    click_link 'Sign up now!'
    is_expected.to have_title 'Sign up'
  end

end
