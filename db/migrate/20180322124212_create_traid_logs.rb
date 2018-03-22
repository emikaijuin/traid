class CreateTraidLogs < ActiveRecord::Migration
  def change
    create_table :traid_logs do |t|
      t.json :history
      t.timestamps null: false
    end
    
  end
end
