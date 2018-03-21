class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.date :birthday
      t.string :email
      t.string :phone_number
      t.string :encrypted_password
      t.string :address
      t.string :secondary_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.timestamps
    end
  end
end
