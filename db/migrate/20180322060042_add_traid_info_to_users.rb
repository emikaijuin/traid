class AddTraidInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_offering, :string, array: true
    add_column :users, :is_seeking, :string, array: true
    add_column :users, :about, :string
  end
end
