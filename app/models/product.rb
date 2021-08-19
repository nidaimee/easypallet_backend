class Product < ApplicationRecord
    has_many :order_products
    has_many :sorted_order_products
end
