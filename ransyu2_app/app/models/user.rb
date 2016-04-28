class User < ActiveRecord::Base
  has_secure_password
  REG_VALID_EMAIL_FORMAT = /\A[\w+.-]+@[a-zA-Z.]+\.[a-zA-Z]+\z/i
  validates :email, presence: true, length: { maximum: 60 }, format: { with: REG_VALID_EMAIL_FORMAT }, uniqueness: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :password, length: { minimum: 6 }
end
