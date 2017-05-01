FactoryGirl.define do
  factory :payment do
    order nil
    status { Faker::Number.between(1, 3) }
    braintree_id { Faker::Number.number(10) }
  end
end
