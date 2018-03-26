require 'rails_helper'
require 'rspec'
require 'rspec-given'

describe User do

	Given (:harold) { User.new(first_name: 'Harold', last_name: 'Houdini', email: 'harold_the_houdini@gmail.com', username: 'harold_houdini', password: 'password') }
	Given (:mathilda) { User.new(first_name: 'Mathilda', last_name: 'Roulen', email: 'mathilda_roulen@gmail.com', username: 'mathilda_roulen', password: 'password') }
  Given (:harolds_traid) {Traid.create(key: "123456", user_id: harold.id)}
  Given (:mathildas_traid) {Traid.create(key: "123456", user_id: mathilda.id)} 
  Given (:user_token) {User.new_token}
  
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
    
    context "returns true if users have traided and user has not reviewed their traid" do 
      Given { mathilda.save && harold.save }
      When { harolds_traid.update(is_reviewable_by_user: true) && mathildas_traid.update(is_reviewable_by_user: true)}
      Then { mathilda.is_reviewable_by?(harold) == true} 
    end
    
    context "returns false if users have traided and user has reviewed their traid" do 
      Given { mathilda.save && harold.save && harolds_traid.save && mathildas_traid.save }
      Then { mathilda.is_reviewable_by?(harold) == false}       
    end
  end
  
  describe "#has_available_traid_review?" do 
    context "returns true if a user has not reviewed a completed traid" do 
      Given { mathilda.save && mathildas_traid.update(is_reviewable_by_user: true) }
      Then {User.has_available_traid_review?(mathilda, "123456") == true}
    end
    
    context "returns false if a user has a completed traid that has already been reviewed" do 
      Given { harold.save }
      Then { User.has_available_traid_review?(harold, "123456") == false}
    end
  end
  
  describe "#new_token" do 
    context "returns a new random token for users who log in via cookies" do
      Given { user_token }
      Then {user_token.length ==  22 && user_token == user_token.to_s}
    end
  end
  
  describe "#remember" do 
    context "saves new token to remember_digest attribute" do 
      Given { harold.remember }
      Then  { harold.remember_digest != nil }
    end
  end
  
  describe "#forget" do 
    context "does not save a token to remember_digest if user is forgotten" do 
      Given { harold.forget }
      Then { harold.remember_digest == nil}
    end
  end
  
  describe "#authenticated?(remember_token)" do
    context "returns false if user.remember_digest is nil" do 
      Given { harold.remember && harold.remember_digest == nil }
      Then { harold.authenticated?(user_token) == false }
    end
  end
  
  describe "#forget" do 
    context "deletes remember_digest" do 
      Given { harold.forget }
      Then { harold.remember_digest == nil }
    end
  end
  

end
