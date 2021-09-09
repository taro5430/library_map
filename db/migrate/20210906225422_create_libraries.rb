class CreateLibraries < ActiveRecord::Migration[6.1]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :address
      t.string :access
      t.string :study_space
      t.string :electrical_outlet
      t.text :detail
      t.integer :user_id

      t.timestamps
    end
  end
end
