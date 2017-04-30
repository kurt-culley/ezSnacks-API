class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.references :restaurant, foreign_key: true
      t.integer    :status
      t.timestamps
    end
  end
end
