class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :hotspring, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: true

      t.timestamps
    end
    add_index :posts, [:user_id, :hotspring_id], unique: true
  end
end
