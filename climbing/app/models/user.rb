class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A\w+@\w+.\w+\z/
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  has_secure_password
end
