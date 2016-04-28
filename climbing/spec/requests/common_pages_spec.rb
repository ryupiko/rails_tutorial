require 'rails_helper'

describe "CommonPages" do
  subject { page }

  describe "HomePage" do
    before { visit root_path }
    it { is_expected.to have_title('Home') }
    it { is_expected.to have_selector('.navbar') }
  end

  describe "AboutPage" do
    before { visit about_path }
    it { is_expected.to have_title('About') }
  end

  describe "ContactPage" do
    before {
      visit contact_path
      fill_in "Name",         with: "testuser"
      fill_in "Email",        with: "test@test.com"
      fill_in "Message",      with: "hidoi!!"
    }
    it { is_expected.to have_title('Contact') }
    it { is_expected.to have_selector('.btn') }

    it "Post valid message" do
      expect { click_button "Contact" }.to change(Contact, :count).by(1)
    end

    describe "Post invalid message" do
      it "invalid email" do
        fill_in "Email",      with: "invalid"
        expect { click_button "Contact" }.not_to change(Contact, :count)
      end
      it "blank email" do
        fill_in "Email",      with: " "
        expect { click_button "Contact" }.not_to change(Contact, :count)
      end
      it "blank message" do
        fill_in "Message",    with: " "
        expect { click_button "Contact" }.not_to change(Contact, :count)
      end
    end
  end

end
