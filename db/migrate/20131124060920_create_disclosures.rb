class CreateDisclosures < ActiveRecord::Migration[4.2]
  def change
    create_table :disclosures do |t|
      t.datetime :release_date
      t.string :code, limit: 6
      t.string :name
      t.string :title
      t.string :pdf
      t.string :zip
      t.integer :stock_id
      t.integer :category, limit: 2, null: false, default: 0

      t.timestamps

      t.index :stock_id, name: "index_disclosures_stock_id"
      t.index [:release_date, :category, :code], name: "index_disclosures_release_date_category_code"
      t.index [:category, :stock_id], name: "index_disclosures_category_stock_id"
      t.index [:code, :release_date], name: "index_disclosures_code_release_date"
      t.index :pdf, name: "index_disclosures_pdf"
    end
  end
end
