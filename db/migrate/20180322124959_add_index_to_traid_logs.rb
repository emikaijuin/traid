class AddIndexToTraidLogs < ActiveRecord::Migration
  def change
    add_index :traid_logs, :history, using: :gin
  end
end
