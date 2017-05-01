FactoryGirl.define do
  factory :menu_category do
    name { Faker::Food.ingredient }
    restaurant_id nil
  end
end
