class Restaurant < ApplicationRecord
  has_many :tables
  has_many :menu_categories
  has_many :orders
end
