class AddReviewStatusToTraids < ActiveRecord::Migration
  def change
    add_column :traids, :is_reviewable_by_user, :boolean, :default => false
  end
end
