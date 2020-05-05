class CreateHighestForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :highest_forecasts do |t|
      t.references :results_forecast, null: false, index: true
      t.date :date, null: false, index: true

      t.timestamps
    end
  end
end
