class UserSerializer
  include JSONAPI::Serializer
  attribute :name

  has_many :comments
  has_many :favorites
  has_many :posts
end
