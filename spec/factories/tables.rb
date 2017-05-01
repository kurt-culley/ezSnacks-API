FactoryGirl.define do
  factory :table do
    restaurant nil
    status { Faker::Number.between(0,2) }
  end
end
