class AddColumnsToLibraries < ActiveRecord::Migration[6.1]
  def change
    add_column :libraries, :image, :string
  end
end
