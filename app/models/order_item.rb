class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order

  validates_presence_of :menu_item_id

  def total_price
    self.quantity * self.menu_item.price
  end

end
