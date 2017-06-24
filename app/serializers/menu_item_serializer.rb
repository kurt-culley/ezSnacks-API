class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :description, :image_url, :name
end
