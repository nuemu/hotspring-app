class UserSerializer
  include JSONAPI::Serializer
  attribute :name

  has_many :comments
end
