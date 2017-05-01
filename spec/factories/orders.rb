FactoryGirl.define do
  factory :order do
    restaurant nil
    payment_id nil
    table_id { Faker::Number.between(1, 3) }
    status { Faker::Number.between(0, 2) }
    items_list { [Faker::Food.ingredient, Faker::Food.ingredient] }
  end
end
