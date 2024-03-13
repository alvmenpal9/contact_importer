class RemoveColumnFromContacts < ActiveRecord::Migration[7.1]
  def change
    remove_column :contacts, :status, :string
  end
end
