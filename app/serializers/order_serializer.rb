class OrderSerializer < ActiveModel::Serializer
  attributes :id, :sub_total
  has_many :order_items
end



