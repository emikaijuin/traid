class DropReviewsAndRatingsTable < ActiveRecord::Migration
  def change
    drop_table :reviews
    drop_table :ratings
  end
end
