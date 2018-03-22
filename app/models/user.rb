class User < ApplicationRecord
  
  # Search 
  include PgSearch
  multisearchable :against => [:city, :is_offering, :is_seeking]

  scope :city, -> (city) { where( "city ILIKE :city", city: "%#{city}%" )}
  scope :is_offering, -> (is_offering) { where("is_offering ILIKE :is_offering", is_offering: "%#{is_offering}%")}
  scope :is_seeking, -> (is_seeking) { where("is_offering ILIKE :is_seeking", is_seeking: "%#{is_seeking}%")}
  
  # Validations and Associations 
  has_secure_password
  attr_accessor :remember_token
  has_many :traids
  

  validates :email, 
    uniqueness: true, 
    presence: true
  validates :username, 
    presence: true
  validates :first_name, 
    presence: true
  validates :last_name, 
    presence: true
  
  # Secure sessions methods 
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember 
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end