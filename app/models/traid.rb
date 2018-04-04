class Traid < ApplicationRecord

  # Associations
  belongs_to :user
  before_save :create_key

  enum status: [ :requested, :negotiating, :canceled, :finalized ]
  
  def create_key
    self.key = SecureRandom.hex(4).upcase unless self.key
  end
  
  def partner
    Traid.where(key: self.key).each do |traid|
      return traid if traid.id != self.id # Method to be modified if group traids are implemented
    end
  end
  
  class << self
    
    def get_active_traids(user)
      traids = []
      if !Traid.where(user_id: user.id).empty?
        Traid.where(user_id: user.id).each do |traid|
          if !traid.canceled? && !traid.finalized?
            traids << traid
          end
        end
      end
      return traids
    end
    
    def unreviewed_traids(user_being_reviewed, user_reviewing)
      unreviewed_traids = []
      Traid.where(user_id: user_reviewing.id).each do |traid|
        if !user_being_reviewed.traids.where(key: traid.key).empty? && traid.is_reviewable_by_user
          unreviewed_traids << [traid.title, traid.key]
        end
      end
      return unreviewed_traids
    end
    
    def has_happened_between_users(user_being_reviewed, user_reviewing)
      traid_found = false
      keys = []
      user_reviewing.traids.each do |traid|
        if !user_being_reviewed.traids.where(key: traid.key).empty?
          traid_found = true
          keys << traid.key
        end
      end
      
      if traid_found == true
        return {"is_true?" => true, "keys" => keys}
      else
        return {"is_true?" => false}
      end
    end
    
    def status(status_1, status_2)
      if status_1 == "negotiating" || status_2 == "negotiating"
        status = "Negotiating"      
      elsif status_1 == "requested" || status_2 == "requested"
        status = "Requested"
      elsif status_1 == nil || status_2 == nil
        status = "Requested"
      elsif ( status_1 == "finalized" && status_2 != "finalized" ) || (status_1 != "finalized" && status_2 == "finalized")
        status = "Traid Finalization Pending Approval"
      elsif status_1 == "canceled" || status_2 == "canceled"
        status = "Canceled"
      elsif status_1 == "finalized" && status_2 == "finalized"
        status = "Traid Finalized"
      end
      return status
    end
    
    def create_copy(user_id, key, traid_params)
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
