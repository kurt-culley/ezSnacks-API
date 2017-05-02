FactoryGirl.define do
  factory :menu_category do
    name { Faker::Food.ingredient }
    image_url { "http://google.com/" }
    restaurant_id nil
  end
end
