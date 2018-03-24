class Review < ApplicationRecord
  belongs_to :user
  
  validates :text, presence: true
  validates :reviewing_user_id, presence: true
  
  def calculate_whole_stars
    self.rating.to_i
  end
  
  def calculate_half_stars
    if self.rating % 1 >= 0.5
      1
    else
      0
    end
  end
end
