class FixUserReferences < ActiveRecord::Migration
  def change
    remove_column :ratings, :users_id, :integer
    remove_column :reviews, :users_id, :integer
    
    add_column :ratings, :user_id, :bigint
    add_column :reviews, :user_id, :bigint
  end
end
