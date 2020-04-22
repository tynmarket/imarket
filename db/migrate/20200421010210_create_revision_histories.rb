class CreateRevisionHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :revision_histories do |t|
      t.string :code, null: false
      t.date :date, null: false
      t.float :divisor, null: false, comment: "除数"
      t.integer :face_value, null: false, default: 1, comment: "額面"

      t.timestamps

      t.index [:code, :date]
    end
  end
end
