class AddTraidInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_to_offer, :string, array: true
    add_column :users, :is_seeking, :string, array: true
    add_column :users, :about, :string
  end
end
