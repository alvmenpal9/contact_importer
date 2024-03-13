class RemoveFilenameFromImports < ActiveRecord::Migration[7.1]
  def change
    remove_column :imports, :file_name, :string
  end
end
