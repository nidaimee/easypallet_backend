class Api::SortedOrderProductSerializer < ActiveModel::Serializer
    attributes :id, :order_id, :layer, :quantity, 
    :created_at, :updated_at, :product_id
end
