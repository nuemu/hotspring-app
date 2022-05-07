class HotspringOnlySerializer
  include JSONAPI::Serializer

  attributes :name, :latitude, :longtitude, :description, :id, :status
  attribute :image_url do |object|
    object.image_url
  end
end
