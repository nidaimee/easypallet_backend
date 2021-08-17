class Api::ProductSerializer < ActiveModel::Serializer
    attributes :id, :label, :ballast
end