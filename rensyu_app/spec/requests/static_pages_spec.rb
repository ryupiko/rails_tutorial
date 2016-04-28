require 'rails_helper'

describe "Static Pages" do

  subject { page }
 
  describe "Home" do
    before { visit root_path }
 
    it { is_expected.to have_title('HomePage') }
  end
 
  describe "Help" do
    before { visit help_path }
 
    it { is_expected.to have_title('Help') }
  end
 
  describe "About" do
    before { visit about_path }
 
    it { is_expected.to have_title('About') }
  end
 
  describe "Contact" do
    before { visit contact_path }
 
    it { is_expected.to have_title('Contact') }
  end

  it "navbar link check" do
    visit root_path
    click_link "Help"
    is_expected.to have_title('Help')
    click_link "About"
    is_expected.to have_title('About')
    click_link "Contact"
    is_expected.to have_title('Contact')
  end

  it "signup_link click" do
    visit root_path
    click_link "Sign up now!"
    is_expected.to have_title('Sign up')
  end

end

