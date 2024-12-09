FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    price { 1.5 }
  end
end
