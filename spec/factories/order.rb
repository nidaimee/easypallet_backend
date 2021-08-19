FactoryBot.define do
    factory :order do
        code { Faker::Lorem.word }
        bay { Faker::Lorem.word }
        load
    end
end
