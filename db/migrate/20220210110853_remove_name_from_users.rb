class RemoveNameFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :last_name_kana
    remove_column :users, :first_name_kana
  end

  def down
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
  end
end
