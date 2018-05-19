class CreateStockSplits < ActiveRecord::Migration[4.2]
  def change
    create_table :stock_splits do |t|
      t.string :code, limit: 6
      t.date :allocation_date
      t.date :split_date
      t.float :split_ratio
      t.date :effect_date
      t.integer :stock_id
      t.integer :disclosure_id

      t.timestamps

      t.index [:disclosure_id, :split_date], name: "index_stock_splits_disclosure_id_split_date"
      t.index [:code, :disclosure_id], name: "index_stock_splits_code_disclosure_id"
    end
  end
end
