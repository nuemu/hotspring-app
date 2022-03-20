class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.integer :admin, null: false, default: 0

      t.timestamps null: false
    end
  end
end
