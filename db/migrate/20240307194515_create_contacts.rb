class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :date_of_birth
      t.string :phone_number
      t.string :address
      t.string :credit_card
      t.string :email
      t.string :franchise
      t.string :status, default: "on hold"
      t.timestamps
    end
  end
end
