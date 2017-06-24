class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :restaurant, foreign_key: true
      t.integer    :status
      t.integer    :table_id
      t.timestamps
    end
  end
end
