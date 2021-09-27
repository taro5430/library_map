class RemoveAvatarFromLibraries < ActiveRecord::Migration[6.1]
  def change
    remove_column :libraries, :avatar, :string
  end
end
