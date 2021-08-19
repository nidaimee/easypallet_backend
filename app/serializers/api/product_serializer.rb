class Api::ProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :ballast, :created_at, :updated_at
end