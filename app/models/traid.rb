class Traid < ApplicationRecord

  # Associations
  belongs_to :user
  before_save :create_key
  
  
  enum status: [ :requested, :negotiating, :canceled, :finalized ]
  
  def create_key
    self.key = SecureRandom.hex(4).upcase unless self.key
  end
  
  class << self
    
    def status(status_1, status_2)
      if status_1 == "requested" || status_2 == "requested"
        return "Requested"
      elsif status_1 == nil || status_2 == nil
        return "Requested"
      elsif status_1 == "negotiating" || status_2 == "negotiating"
        return "Negotiating"
      elsif ( status_1 == "finalized" && status_2 != "finalized" ) || (status_1 != "finalized" && status_2 == "finalized")
        return "Traid Finalization Pending Approval"
      elsif status_1 == "canceled" || status_2 == "canceled"
        return "Canceled"
      elsif status_1 == "finalized" && status_2 == "finalized"
        return "Traid Finalized"
      end
    end
    
    def create_copy(user_id, key)
      @traid_copy = Traid.new
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
