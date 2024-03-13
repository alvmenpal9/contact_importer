class AddColumnToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :imported_by, :integer
  end
end
