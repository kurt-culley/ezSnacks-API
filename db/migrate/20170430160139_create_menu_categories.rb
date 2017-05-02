class CreateMenuCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_categories do |t|
      t.references :restaurant, foreign_key: true
      t.string     :name
      t.string     :image_url
      t.timestamps
    end
  end
end
