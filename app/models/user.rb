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
  has_many :reviews
  has_many :ratings
  

  validates :email, 
    uniqueness: true, 
    presence: true
  validates :username, 
    presence: true
  validates :first_name, 
    presence: true
  validates :last_name, 
    presence: true
  
  # Model Methods
  
  def rating
    rating = 0
    count = 0
    if !self.reviews.empty?
      self.reviews.each do |review|
        if review.rating # In case user only submitted review
          rating += review.rating.to_i
          count += 1
        end
      end
      return rating / count
    else
      return 0
    end
  end
    
  def is_reviewable_by?(user)
    traid_info = Traid.has_happened_between_users(self, user) # self => user from show page being reviewed
    if traid_info["is_true?"]
      if User.has_available_traid_review?(user, traid_info["key"])
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def self.has_available_traid_review?(reviewing_user, key)
    Traid.all.where(key: key).each do |traid|
      return true if traid.user_id == reviewing_user.id && traid.is_reviewable_by_user
    end
    return false
  end
  
  # Google Login methods
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email= auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password = SecureRandom.hex(8)
      user.save!
    end
  end
  
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