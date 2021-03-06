require 'rails_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { is_expected.to have_content('Sign up') }

    describe "with valid information" do
      before do
        fill_in "Name",         with: "example user"
        fill_in "Email",        with: "example@email.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { is_expected.to have_content(user.name) }
    it { is_expected.to have_title(user.name) }
  end

end
