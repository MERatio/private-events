class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 255 }
  validates :username, presence: true, length: { maximum: 16 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { in: 6..20 }   
  
  private

    # Converts email to all lowercase
    def downcase_email
      email.downcase!  
    end
end
