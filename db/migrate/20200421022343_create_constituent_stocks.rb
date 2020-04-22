class CreateConstituentStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :constituent_stocks do |t|
      t.references :revision_history, null: false, index: true
      t.references :stock, null: false, index: true
      t.integer :face_value_numerator, null: false, default: 1, comment: "みなし額面（分子）"
      t.integer :face_value_denominator, null: false, default: 1, comment: "みなし額面（分母）"

      t.timestamps
    end
  end
end
