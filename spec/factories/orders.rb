FactoryGirl.define do
  factory :order do
    restaurant nil
    table_id { Faker::Number.between(1, 3) }
  end
end
