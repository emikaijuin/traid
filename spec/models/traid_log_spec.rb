require 'rails_helper'
require 'rspec'
require 'rspec-given'

describe TraidLog do


	Given (:harold) { User.new(first_name: 'Harold', last_name: 'Houdini', email: 'harold_the_houdini@gmail.com', username: 'harold_houdini', password: 'password') }
	Given (:mathilda) { User.new(first_name: 'Mathilda', last_name: 'Roulen', email: 'mathilda_roulen@gmail.com', username: 'mathilda_roulen', password: 'password') }

  
  describe "#rating" do
    context "returns 0 when user has not been rated" do
     Then { mathilda.rating == 0 }
    end
    
    context "returns average rating when user has multiple ratings" do 
    When { harold.reviews.new(traid_key: "123456", reviewing_user_id: mathilda.id, rating: 3, text: "abcdefg", user_id: harold.id) }
    Then { harold.rating == 3}
    end
  end
  
  describe "#is_reviewable_by?(user)" do
    context "returns false if users have not traided" do 
      Then { mathilda.is_reviewable_by?(harold) == false }
    end
    
    # context "returns true if users have traided and user has not reviewed their traid" do 
    #   When {
    #     Traid.new(user_id: harold.id, key: "123456", is_reviewable_by_user: true)
    #     Traid.new(user_id: mathilda.id, key: "123456", is_reviewable_by_user: true)
    #   }
    #   Then { mathilda.is_reviewable_by?(harold) == true} 
    # end
  end
  
  # describe "#has_available_traid_review?" do 
  #   context ""
  # end
  

end
