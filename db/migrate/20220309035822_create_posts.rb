class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :hotspring, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :accesibility
      t.integer :water_tempreature
      t.integer :gas_risk

      t.timestamps
    end
  end
end
