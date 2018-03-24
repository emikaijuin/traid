class ChangeColumnNamesRatingsAndReviews < ActiveRecord::Migration
  def change
    rename_column :ratings, :rated_user_id, :rating_user_id
    rename_column :reviews, :reviewed_user_id, :reviewing_user_id
  end
end
