class AddKeyToTraidLog < ActiveRecord::Migration
  def change
    add_column :traid_logs, :key, :string
  end
end
