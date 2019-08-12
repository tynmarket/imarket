class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :stock_id, null: false

      t.timestamps

      t.index [:user_id, :stock_id], unique: true
      t.index :stock_id
    end
  end
end
