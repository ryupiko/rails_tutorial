require 'rails_helper'

describe "User pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "show page" do
    before { visit user_path(user) }
    let(:name) { user.name }
    it { is_expected.to have_title(name) }
    it { is_expected.to have_content(name) }
  end

  describe "signup page" do
    before { visit signup_path }
    describe "valid signup" do
      before do
        fill_in "Name",         with: "testuser"
        fill_in "Email",        with: "test@test.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "success signup" do
        expect { click_button "Signup" }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button "Signup" }
        it { is_expected.to have_title('testuser') }
        it { is_expected.to have_selector('div.alert-success', text: 'Welcome') }
        it { pending 'session yet created'
          is_expected.to have_link('Signout') }
      end
     
    end
    describe "invalid signup" do
      it "not success signup" do
        expect { click_button "Signup" }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button "Signup" }
        it { is_expected.to have_title('Signup') }
        it { is_expected.to have_selector('#error_explanation') }
      end
    end
  end
end
