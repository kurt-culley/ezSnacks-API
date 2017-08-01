class OrderSerializer < ActiveModel::Serializer
  attributes :id, :sub_total, :status, :table_id
  has_many :order_items
end



