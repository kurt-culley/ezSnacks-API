class Order < ApplicationRecord
  serialize :items_list, Array
  belongs_to :restaurant
  has_one :payment

  validates_presence_of :status, :table_id, :items_list
end
