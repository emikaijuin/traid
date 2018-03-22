class CreateTraids < ActiveRecord::Migration
  def change
    create_table :traids do |t|
      t.string :title
      t.string :conditions
      t.string :offer
      t.string :offer_type
      t.string :quantity
      t.string :key
      t.int :user_id, null => false, :references => [:users, :id]
      t.timestamps null: false
    end
  end
end
