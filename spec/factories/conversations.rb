FactoryBot.define do
  factory :conversation do
    name { Faker::Lorem.word }
    status { true }
  end
end
