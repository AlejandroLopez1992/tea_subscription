FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { Faker::Number.between(from: 100, to: 10000) }
    frequency { Faker::Number.between(from: 0, to: 3) }
  end
end
