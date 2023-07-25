FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::String.random }
    temperature { Faker::Number.between(from: 0, to: 250) }
    brew_time { Faker::Number.between(from: 0, to: 1800) }
  end
end
