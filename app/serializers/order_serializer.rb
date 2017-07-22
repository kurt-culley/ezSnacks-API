class OrderSerializer < ActiveModel::Serializer
  attributes :id, :sub_total, :status
  has_many :order_items
end



