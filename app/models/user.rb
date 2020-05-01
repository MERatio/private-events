class User < ApplicationRecord
  has_many :events, foreign_key: 'creator_id', class_name: 'Event'
  before_save :downcase_email
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 255 }
  validates :username, presence: true, length: { maximum: 16 },
                       uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { in: 6..20 }   
  
  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random 16 character string
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Store a hash version of token for cookie session authentication
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if hash version of remember_token and remember_token is the same
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Delete the hash version of remember_token
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

    # Converts email to all lowercase
    def downcase_email
      email.downcase!  
    end
end
