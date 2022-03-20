class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :hotspring, null: false, foreign_key: true
      t.text :url, null: false, unique: true

      t.timestamps
    end
  end
end
