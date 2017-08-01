class Order < ApplicationRecord
  belongs_to :table
  has_many :order_items, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :menu_items, through: :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

  after_initialize :set_default_status, :if => :new_record?
  validates_presence_of :table_id, :status

  enum status: [:pending_payment, :settling_payment, :in_progress, :complete, :canceled]

  def set_default_status
    self.status ||= :pending_payment
  end

  def sub_total
    sum = 0
    self.order_items.each do |item|
      sum += item.total_price
    end
    return sum
  end
end
