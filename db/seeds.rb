
menu_categories = [
    [ "Hot Drinks", "https://png.icons8.com/cafe/ios7/100" ],
    [ "Cold Drinks", "https://png.icons8.com/soda-cup/ios7/100" ],
    [ "Bakery", "https://png.icons8.com/cupcake/ios7/100" ],
    [ "Snacks", "https://png.icons8.com/nachos/ios7/100" ],
    [ "Breakfast", "https://png.icons8.com/pancake/ios7/100" ],
    [ "Lunch", "https://png.icons8.com/pizza/ios7/100" ]
]

category_items = [
    [ "Large Coffee", "1L", "https://png.icons8.com/cafe/ios7/100", 2 ],
    [ "Medium Coffee", "500mL", "https://png.icons8.com/cafe/ios7/100", 1.50 ],
    [ "Small Coffee", "250mL", "https://png.icons8.com/cafe/ios7/100", 1 ]
]

restaurant = Restaurant.create(name: "Starbucks")

menu_categories.each do |name, image_url|
  MenuCategory.create(name: name, image_url: image_url, restaurant_id: restaurant.id)
end

category_items.each do |name, description, image_url, price|
  MenuItem.create(name: name, description: description, image_url: image_url,
                  price: price, menu_category_id: MenuCategory.first.id)
end

5.times { restaurant.tables.create({"status": 0}) }

restaurant.tables.each do |table|
  table.orders.create
end

restaurant.tables.each do |table|
  table.orders.first.order_items.create({ menu_item_id: rand(1..3) } )
end
