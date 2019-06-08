class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :taisyaku_code, :string, limit: 6, after: :is_consolidated
  end
end
