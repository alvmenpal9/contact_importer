class CreateImports < ActiveRecord::Migration[7.1]
  def change
    create_table :imports do |t|
      t.integer :user_id
      t.string :file_name
      t.string :status
      t.timestamps
    end
  end
end
