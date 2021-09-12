class RenameImageColumnToLibraries < ActiveRecord::Migration[6.1]
  def change
    rename_column :libraries, :image, :avatar
  end
end
