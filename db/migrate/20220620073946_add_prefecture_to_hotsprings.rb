class AddPrefectureToHotsprings < ActiveRecord::Migration[6.1]
  def change
    add_column :hotsprings, :prefecture, :string
  end
end
