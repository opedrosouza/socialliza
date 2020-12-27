FactoryBot.define do
  factory :room do
    name { Faker::Internet.slug }
  end
end