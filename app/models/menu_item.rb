class MenuItem < ApplicationRecord
  belongs_to :menu_category

  validates_presence_of :name, :description, :image_url, :menu_category, :price
end
