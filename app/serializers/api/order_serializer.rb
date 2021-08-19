class Api::OrderSerializer < ActiveModel::Serializer
    attributes :id, :load_id, :code, :bay, :updated_at, :created_at
end
