require 'rails_helper'

describe "User" do

  before {
    @user = User.new(name: "ryuji",
                     email: "ryu@email.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  }
  subject { @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:authenticate) }

  describe "Name" do
    describe "is too long" do
      before { @user.name = 'a' * 50 }
      it { is_expected.not_to be_valid }
    end
    describe "is blank" do
      before { @user.name = "" }
      it { is_expected.not_to be_valid }
    end
  end

  describe "Email" do
    describe "is too long" do
      before { @user.email = "#{'a' * 50}@email.com" }
      it { is_expected.not_to be_valid }
    end
    describe "is blank" do
      before { @user.email = "" }
      it { is_expected.not_to be_valid }
    end
    describe "is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end
      it { is_expected.not_to be_valid }
    end
  end

  describe "Password" do
    describe "is too short" do
      before { @user.password = "test" }
      it { is_expected.not_to be_valid }
    end
  end
end
