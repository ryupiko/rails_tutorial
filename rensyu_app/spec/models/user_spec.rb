require 'rails_helper'

describe User do
  before { @user = User.new(name: "Example User",
                            email: "user@example.com",
                            password: "foobar",
                            password_confirmation: "foobar") }

  subject { @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }

  it { is_expected.to respond_to(:authenticate) }

  it { is_expected.to be_valid }

  describe "invalid user inf" do
    describe "email blank" do
      before { @user.email = " " }
      it { is_expected.not_to be_valid }
    end
    describe "name blank" do
      before { @user.name = " " }
      it { is_expected.not_to be_valid }
    end
    describe "name length too long" do
      before { @user.name = "#{'a'*30}" }
      it { is_expected.not_to be_valid }
    end
    describe "email length too long" do
      before { @user.email = "#{'a'*50}@sample.com" }
      it { is_expected.not_to be_valid }
    end
    it "email format" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        is_expected.not_to be_valid
      end
    end

    describe "email double check" do
      before do
        user_with_same_email = @user.dup
        user_with_sama_email = @user.email.upcase
        user_with_same_email.save
      end
      it { is_expected.not_to be_valid }
    end

  end

  describe "valid user inf" do
    it "email format" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        is_expected.to be_valid
      end
    end
  end

  describe "password is not present" do
    before do
      @user.password = " "
      @user.password_confirmation = " "
    end
    it { is_expected.not_to be_valid }
  end

  describe "password doesn't match confirmation" do
    before { @user.password_confirmation = " " }
    it { is_expected.not_to be_valid }
  end
  describe "check authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    describe "with valid password" do
      it { is_expected.to eq found_user.authenticate(@user.password) }
    end
    describe "with invalid password" do
      let(:user_invalid_pass) { found_user.authenticate("invalid") }
      it { expect(user_invalid_pass).to be_falsey }
    end
  end

  describe "password too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { is_expected.not_to be_valid }
  end

end
