class CreateTraids < ActiveRecord::Migration
  def change
    create_table :traids do |t|

      t.timestamps null: false
    end
  end
end
