class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order

  after_initialize :set_default_status, :if => :new_record?
  validates_presence_of :menu_item_id

  enum status: [:in_progress, :complete]

  def set_default_status
    self.status ||= :in_progress
  end

  def total_price
    self.quantity * self.menu_item.price
  end

end
