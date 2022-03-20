class ArticleSerializer
  include JSONAPI::Serializer
  attribute :url

  attribute :user do |obj|
    UserSerializer.new(obj.user)
  end

  belongs_to :hotspring
  belongs_to :user
end
