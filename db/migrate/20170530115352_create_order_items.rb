class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity, :default => 1
      t.integer :menu_item_id
      t.integer :order_id

      t.timestamps
    end
  end
end
