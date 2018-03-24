class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :traid_key
      t.integer :value
      t.references :users
      t.integer :rated_user_id
      t.timestamps null: false
    end
  end
end
