class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, after: :email

    add_index :users, :name
  end
end
