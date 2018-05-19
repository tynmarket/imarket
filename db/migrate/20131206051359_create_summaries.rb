class CreateSummaries < ActiveRecord::Migration[4.2]
  def change
    create_table :summaries do |t|
      t.string :code, limit: 6
      t.integer :year, limit: 2
      t.integer :month, limit: 1
      t.integer :quarter, limit: 1
      t.boolean :is_consolidated, default: true
      t.integer :net_sales
      t.integer :operating_income
      t.integer :ordinary_income
      t.integer :net_income
      t.float :net_income_per_share
      t.float :change_in_net_sales
      t.float :change_in_operating_income
      t.float :change_in_ordinary_income
      t.float :change_in_net_income
      t.integer :prior_net_sales
      t.integer :prior_operating_income
      t.integer :prior_ordinary_income
      t.integer :prior_net_income
      t.float :prior_net_income_per_share
      t.float :change_in_prior_net_sales
      t.float :change_in_prior_operating_income
      t.float :change_in_prior_ordinary_income
      t.float :change_in_prior_net_income
      t.integer :disclosure_id
      t.integer :owners_equity
      t.integer :number_of_shares, limit: 8
      t.integer :number_of_treasury_stock, unsigned: true
      t.float :net_assets_per_share

      t.timestamps

      t.index :disclosure_id, name: "index_summaries_disclosure_id"
      t.index :code, name: "index_summaries_code"
    end
  end
end
