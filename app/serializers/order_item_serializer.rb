class OrderItemSerializer < ActiveModel::Serializer
  has_one :menu_item
  attributes :id, :quantity, :total_price
end
