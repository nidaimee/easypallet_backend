FactoryBot.define do
    factory :load do
        code { Faker::Lorem.word }
        delivery_date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end
end
