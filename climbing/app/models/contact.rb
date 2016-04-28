class Contact < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A\w+@\w+.\w+\z/
  validates :name,  presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true
end
