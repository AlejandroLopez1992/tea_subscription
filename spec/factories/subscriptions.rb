FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { Faker::Number.between(from: 100, to: 10000) }
    status { 0 }
    frequency { Faker::Number.between(from: 0, to: 4) }
    tea { nil }
    customer { nil }
  end
end
