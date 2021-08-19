FactoryBot.define do
    factory :product do
        name { Faker::Lorem.word }
        ballast { rand(20...30) }
    end
end