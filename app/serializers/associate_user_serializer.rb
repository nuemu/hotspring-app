class AssociateUserSerializer
  include JSONAPI::Serializer
  attribute :name

  attribute :image_url do |object|
    object.generate_image_url
  end
end
