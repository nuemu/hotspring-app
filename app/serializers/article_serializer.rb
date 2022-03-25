class ArticleSerializer
  include JSONAPI::Serializer
  attribute :url

  attribute :user do |obj|
    AssociateUserSerializer.new(obj.user)
  end
end
