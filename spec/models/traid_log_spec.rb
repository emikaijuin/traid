require 'rails_helper'
require 'rspec'
require 'rspec-given'

describe TraidLog do

  Given (:key) {"123456"}
	Given (:harold) { User.new(first_name: 'Harold', last_name: 'Houdini', email: 'harold_the_houdini@gmail.com', username: 'harold_houdini', password: 'password') }
	Given (:mathilda) { User.new(first_name: 'Mathilda', last_name: 'Roulen', email: 'mathilda_roulen@gmail.com', username: 'mathilda_roulen', password: 'password') }
  Given (:harolds_traid) {Traid.new(key: "123456", user_id: harold.id, title: "Traid", conditions: "conditions", offer: "offer", offer_type: "goods", offer_subtype: "produce", quantity: "1")}
  Given (:mathildas_traid) {Traid.new(key: "123456", user_id: mathilda.id, title: "Traid", conditions: "conditions", offer: "offer", offer_type: "goods", offer_subtype: "produce", quantity: "1")} 
  # Given (:traid_log) { TraidLog.find_by(key: key) }
  
  describe "#add_to_traid_log(key)" do 
    
    context "it takes one argument" do 
      Then { expect{TraidLog.add_traid_to_log}.to raise_error(ArgumentError)} 
    end
    
    context "it creates a new traid log if one doesn't exist" do 
      Given {TraidLog.add_traid_to_log(key)}
      Then {TraidLog.find_by(key: key) != nil}
    end
    
    context "it creates a single entry in the history column" do 
      Given { TraidLog.add_traid_to_log(key) }
      Then { TraidLog.find_by(key: key)["history"].length == 1 }
    end
    
    context "the history column contains two copies of traids" do 
      Given { harold.save && mathilda.save && harolds_traid.save && mathildas_traid.save  }
      When { TraidLog.add_traid_to_log(key) }
      Then {TraidLog.find_by(key: key)["history"][TraidLog.find_by(key: key)["history"].keys[0]].length == 2}
    end
  end
  
  describe "#create_new_traid_log(key)" do 
    
    context "it creates a hash" do 
      Given { harold.save && mathilda.save && harolds_traid.save && mathildas_traid.save  }
      When (:output){TraidLog.create_new_traid_log(key)} 
      Then { output.class == Hash  }
    end
    
    context "it saves harolds and mathildas traids" do 
      Given { harold.save && mathilda.save && harolds_traid.save && mathildas_traid.save }
      When (:output){ TraidLog.create_new_traid_log(key) }
      Then { output.include?(harold.id) &&  output.include?(mathilda.id) }
    end
    
    context "it takes one argument" do 
      Then { expect{TraidLog.create_new_traid_log}.to raise_error(ArgumentError) }
    end
  end

end
