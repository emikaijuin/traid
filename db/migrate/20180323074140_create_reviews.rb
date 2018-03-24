class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :traid_key
      t.integer :reviewing_user_id
      t.float :rating
      t.string :text
    end
    add_reference :reviews, :user, foreign_key: true
  end
end
