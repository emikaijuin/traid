class AddStatusesToTraids < ActiveRecord::Migration
  def change
    add_column :traids, :status, :int
  end
end
