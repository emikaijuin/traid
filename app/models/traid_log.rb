class TraidLog < ApplicationRecord
  
  def self.add_traid_to_log(key)
    if TraidLog.where(key: key).empty? 
      traid_log = TraidLog.create(key: key, history: Hash.new)
    else
      traid_log = TraidLog.find_by(key: key)
    end
    
    new_traid_log = TraidLog.create_new_traid_log(key)
    traid_log.history[Time.now] = new_traid_log
    traid_log.save
  end
  
  def self.create_new_traid_log(key)
    new_traid_log = Hash.new
    Traid.where(key: key).each do |traid|
        new_traid_log[traid.user_id] = traid
    end
    new_traid_log
  end
  
end
