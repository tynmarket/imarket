class CreateEpsEstimates < ActiveRecord::Migration[6.0]
  def change
    create_table :eps_estimates do |t|
      t.string :code, null: false
      t.date :date, null: false
      t.string :current_quarter, null: false
      t.string :next_quarter, null: false
      t.string :current_year, null: false
      t.string :next_year, null: false
      t.float :current_quarter_eps, null: false
      t.float :next_quarter_eps, null: false
      t.float :current_year_eps, null: false
      t.float :next_year_eps, null: false

      t.timestamps

      t.index [:code, :date]
    end
  end
end
