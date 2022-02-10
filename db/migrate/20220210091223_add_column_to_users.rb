class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :telephone_number, :string
    add_column :users, :image, :string
    add_column :users, :is_deleted, :boolean
  end
end
