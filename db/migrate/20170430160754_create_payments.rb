class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.integer    :status
      t.string     :braintree_id
      t.timestamps
    end
  end
end
