class CreateErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :errors do |t|
      t.references :import, foreign_key: true
      t.string :error
      t.string :contact_name
      t.timestamps
    end
  end
end
