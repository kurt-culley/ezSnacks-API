# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

restaurant = Restaurant.create(name: "Starbucks")
menu_category = MenuCategory.create(restaurant_id: restaurant.id,name: "Cookies", image_url: "https://www.pindarcreative.co.uk/images/cookie.png")
MenuItem.create(menu_category_id: menu_category.id, name: "Chocolate Chip",
                image_url: "https://www.pindarcreative.co.uk/images/cookie.png", price: 4.2, description: "Chocolate Cookie.")
MenuItem.create(menu_category_id: menu_category.id, name: "White Chocolate Chip",
                image_url: "http://www.chatfieldsbrand.com/sites/default/files/DSC_8254-2-cookies.png?1351873685", price: 2, description: "White Chocolate Cookie.")