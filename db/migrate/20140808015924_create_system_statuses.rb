class CreateSystemStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :system_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
