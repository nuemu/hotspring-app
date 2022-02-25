class CreateHotsprings < ActiveRecord::Migration[6.1]
  def change
    create_table :hotsprings do |t|
      t.string :name
      t.integer :status, null: false, default: 0
      t.float :latitude, null: false
      t.float :longtitude, null: false
      t.text :description

      t.timestamps
    end
  end
end
