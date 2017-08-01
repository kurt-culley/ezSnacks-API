class Restaurant < ApplicationRecord
  has_many :tables, dependent: :destroy
  has_many :menu_categories, dependent: :destroy
  has_many :orders, through: :tables, dependent: :destroy

  validates_presence_of :name
end
