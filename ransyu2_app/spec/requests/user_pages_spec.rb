require 'rails_helper'

describe "User Pages" do

  subject { page }

  describe "Profile" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { is_expected.to have_content(user.name) }
    it { is_expected.to have_content(user.email) }
  end
  
  describe "SignUp" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    describe "valid inf regist" do
      before do
        fill_in "Name",            with: "example user"
        fill_in "Email",           with: "example@aaa.com"
        fill_in "Password",        with: "foobar"
        fill_in "Confirmation",    with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    describe "invalid inf regist" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "show error mes" do
        before { click_button submit }
        it { is_expected.to have_content('error') }
      end
    end
  end
  
end
