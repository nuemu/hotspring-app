class FavoriteSerializer
  include JSONAPI::Serializer
  attribute :hotspring_id

  belongs_to :hotspring
  belongs_to :user
end
