class Order < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :status, :items_list, :payment_id, :table_id
end
