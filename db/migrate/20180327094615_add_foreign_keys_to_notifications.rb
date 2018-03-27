class AddForeignKeysToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :user, foreign_key: true
    add_reference :notifications, :traid, foreign_key: true
  end
end
