class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items do |t|
      t.references :menu_category, foreign_key: true
      t.string :name
      t.float  :price
      t.string :image_url
      t.text   :description

      t.timestamps
    end
  end
end
