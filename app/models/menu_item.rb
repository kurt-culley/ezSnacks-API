class MenuItem < ApplicationRecord
  belongs_to :menu_category
  has_many :order_items, dependent: :destroy
  validates_presence_of :name, :description, :image_url, :menu_category, :price
end
