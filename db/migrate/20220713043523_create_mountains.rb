class CreateMountains < ActiveRecord::Migration[6.1]
  def change
    create_table :mountains do |t|
      t.string :name, null: false
      t.string :ruby
      t.string :prefecture, null: false
      t.string :location, null: false
      t.string :height, null: false
      t.float :latitude, null: false
      t.float :longtitude, null: false

      t.timestamps
    end
    add_index :mountains, [:latitude, :longtitude], unique: true
  end
end
