class CreateHotsprings < ActiveRecord::Migration[6.1]
  def change
    create_table :hotsprings do |t|
      t.string :name, null: false, default: '未探索'
      t.integer :status, null: false, default: 0
      t.float :latitude, null: false
      t.float :longtitude, null: false
      t.text :description, null: false
      t.text :image_url
      t.boolean :fix, null: false, default: false

      t.timestamps
    end
    add_index :hotsprings, [:latitude, :longtitude], unique: true
  end
end
