class AddTextToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :text, :string
  end
end
