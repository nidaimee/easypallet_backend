class Api::OrderProductSerializer < ActiveModel::Serializer
    attributes :id, :order_id, :product_id, :quantity, 
    :created_at, :updated_at
end