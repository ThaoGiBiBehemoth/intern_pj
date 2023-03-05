class User < ApplicationRecord
  has_many :microposts, dependent: :destroy   #dependent: :destroy   dùng để huỷ luôn micro khi ng dùng bị huỷ

  
  before_save { email.downcase! }    #  before_save { self.email = email.downcase }
  validates :name, uniqueness: { case_sensitive: true }, length: {maximum: 50}
  validates :email, uniqueness: true, presence: true, length: {maximum: 255}, format: {with: URI::MailTo::EMAIL_REGEXP}  #Thành

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    #custom validate
  # validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true




  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


  # Returns the hash digest of the given string.  đại loại là hàm băm, chưa tìm hiểu sâu
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end



  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    Micropost.where("user_id = ?", id)
  end


  private

    # Converts email to all lower-case.
    def downcase_email
    self.email = email.downcase
    end


end
