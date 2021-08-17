class OrderProduct < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  has_one :sorted_order_product, dependent: :destroy
end
