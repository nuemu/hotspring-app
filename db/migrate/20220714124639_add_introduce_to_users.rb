class AddIntroduceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduce, :string, null: false, default: '未記入'
  end
end
