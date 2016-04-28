require 'rails_helper'

describe "User" do

  before { @user = User.new(name: "honda ryuji",
                            email: "honda@test.com",
                            password: "foobar",
                            password_confirmation: "foobar") }
  subject { @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }

  it { is_expected.to respond_to(:authenticate) }
  
  it { is_expected.to be_valid }

  describe "User invalid information" do
    describe "name too long" do
      before { @user.name = "a" * 30 }
      it { is_expected.not_to be_valid }
    end
    describe "name blank" do
      before { @user.name = " " }
      it { is_expected.not_to be_valid }
    end
    
    describe "email too long" do
      before { @user.email = "#{ 'a' * 50 }@testaaaaa.com" }
      it { is_expected.not_to be_valid }
    end
    describe "email blank" do
      before { @user.email = " " }
      it { is_expected.not_to be_valid }
    end
    it "email format invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |address|
        @user.email = address
        is_expected.not_to be_valid
      end
    end
    describe "email double check" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.save
      end
      it { is_expected.not_to be_valid }
    end

    describe "password blank" do
      before { @user.password = " " }
      it { is_expected.not_to be_valid }
    end
    describe "password too short" do
      before { @user.password = "short" }
      it { is_expected.not_to be_valid }
    end
    describe "confirmation blank" do
      before { @user.password_confirmation = " " }
      it { is_expected.not_to be_valid }
    end
    describe "password and confirmation not match" do
      before { @user.password_confirmation = "a" * 6 }
      it { is_expected.not_to be_valid }
    end
  end

  describe "User valid information" do
    it "email format valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |address|
        @user.email = address
        is_expected.to be_valid
      end
    end
  end

  describe "check authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    describe "valid inf" do
      it { is_expected.to eq found_user.authenticate(@user.password) }
    end
    describe "invalid inf" do
      let(:invalid_pass_user) { found_user.authenticate("invalid") }
      it { expect(invalid_pass_user).to be_falsey }
    end
  end
end
