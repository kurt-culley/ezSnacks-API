FactoryGirl.define do
  factory :menu_item do
    menu_category_id nil
    name { Faker::Food.ingredient }
    price { Faker::Number.decimal(2) }
    image_url { Faker::Internet.domain_name }
    description { Faker::Food.spice }
  end
end
