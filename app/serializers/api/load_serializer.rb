class Api::LoadSerializer < ActiveModel::Serializer
    attributes :code, :id, :delivery_date, :updated_at, :created_at
end