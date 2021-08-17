class Api::OrderSerializer < ActiveModel::Serializer
    attributes :id, :load_id, :code, :bay
    has_many :order_products, serializer: Api::OrderProductSerializer

end
