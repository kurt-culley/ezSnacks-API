FactoryGirl.define do
  factory :restaurant do
    name { Faker::Company.name }
  end
end
