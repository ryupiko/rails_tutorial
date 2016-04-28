require 'rails_helper'

describe User do

  before { @user = User.new(name: "test user", email: "test@test.com",
                            password: "foobar", password_confirmation: "foobar") }

  subject{ @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:remember_token) }
  it { is_expected.to respond_to(:authenticate) }

  it { is_expected.to be_valid }

  context "when name is not present" do
    before { @user.name = " " }
    it { is_expected.not_to be_valid }
  end

  context "when email is not present" do
    before { @user.email = " " }
    it { is_expected.not_to be_valid }
  end

  context "when name is too long" do
    before { @user.name = "a" * 51 }
    it { is_expected.not_to be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_ato_foo.org example.user@foo.
                    foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        is_expected.not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        is_expected.to be_valid
      end
    end
  end

  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { is_expected.not_to be_valid }
  end

  describe"email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExamPle.CoM" }
    before do
      @user.email = mixed_case_email
      @user.save
    end
    it { expect(@user.reload.email).to eq mixed_case_email.downcase }
  end

  context "when password is not present" do
    before do
      @user = User.new(name:"test user", email: "test@test.com", password: "", password_confirmation: "")
    end
    it { is_expected.not_to be_valid }
  end

  context "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { is_expected.not_to be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    context "with valid password" do
      it { is_expected.to eq found_user.authenticate(@user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { is_expected.not_to eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
