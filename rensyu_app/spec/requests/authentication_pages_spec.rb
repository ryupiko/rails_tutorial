require 'rails_helper'

describe "Authentication Pages" do

  subject { page }

  describe "signin path" do
    before { visit signin_path }

    it { is_expected.to have_content("Sign in") }
  end
end
