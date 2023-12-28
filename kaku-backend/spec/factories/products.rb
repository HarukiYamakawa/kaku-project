FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    price { Faker::Number.number(digits: 2) }
    description { Faker::Lorem.paragraph }
    image_url { Faker::Lorem.word }
  end
end
