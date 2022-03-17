class ArticleSerializer
  include JSONAPI::Serializer
  attribute :url

  belongs_to :hotspring
end
