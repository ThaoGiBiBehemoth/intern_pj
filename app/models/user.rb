class User < ApplicationRecord
  before_save { email.downcase! }    #  before_save { self.email = email.downcase }
  validates :name, uniqueness: { case_sensitive: true }, length: {maximum: 50}
  validates :email, uniqueness: true, presence: true, length: {maximum: 255}, format: {with: URI::MailTo::EMAIL_REGEXP}  #Thành

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    #custom validate
  # validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true




  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
