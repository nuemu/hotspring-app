class HotspringSerializer
  include JSONAPI::Serializer

  attributes :name, :latitude, :longtitude, :description, :id, :status, :prefecture
  attribute :image_url do |object|
    object.image_url
  end

  has_many :comments, serializer: CommentSerializer
  has_many :articles, serializer: ArticleSerializer
  has_many :posts, serializer: PostSerializer
end
