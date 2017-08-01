class MenuCategory < ApplicationRecord
  has_many :menu_items, dependent: :destroy
  belongs_to :restaurant

  validates_presence_of :name, :image_url
end
