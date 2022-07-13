class MountainSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :ruby, :height, :prefecture, :location, :latitude, :longtitude

  attribute :image_url do |object|
    object.generate_image_url
  end
end
