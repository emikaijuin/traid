class Traid < ApplicationRecord
  belongs_to :user
  before_save :create_key
  
  def create_key
    self.key = SecureRandom.hex(4).upcase unless self.key
  end
  
  class << self
    
    def create_copy(user_id, traid_params, key)
      @traid_copy = Traid.new(traid_params)
      @traid_copy.user = User.find(user_id)
      @traid_copy.key = key
      @traid_copy
    end
    
    def offer_types
      ["Goods", "Services"]
    end
    
    def offer_subtypes
      # Hash format to be implemented when AJAX is added to form
      # {
      #     "Goods" => ["Appliances", "Arts & Crafts", "Books", "Clothes", "Furniture", "Household", "Produce (Homegrown)", "Jewelry", "Tickets", "Toys & Games", "Other"],
      #     "Services" => ["Automotive", "Beauty", "Cell/Mobille", "Computer", "Creative", "Cycle", "Event", "Farm + Garden", "Financial", "Household", "Labor/Move", "Legal", "Lessons", "Marine", "Pet", "Real Estate", "Skilled Trade", "Travel/Vac", "Write/Ed/Trans", "Other"]
      # }
      
      [ "Appliances", "Arts & Crafts", "Books", "Clothes", "Furniture", "Household", "Produce (Homegrown)", "Jewelry", "Tickets", "Toys & Games", "Automotive", "Beauty", "Cell/Mobille", "Computer", "Creative", "Cycle", "Event", "Farm + Garden", "Financial", "Household", "Labor/Move", "Legal", "Lessons", "Marine", "Pet", "Real Estate", "Skilled Trade", "Travel/Vac", "Write/Ed/Trans", "Other"]
    end
  end
  

end
