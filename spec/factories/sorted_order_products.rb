FactoryBot.define do
    factory :sorted_order_product do
        order
        product
        layer { rand(1...5) }
        quantity { rand(1...10) }
    end
end