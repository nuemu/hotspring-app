class HotspringSerializer
  include JSONAPI::Serializer
  attributes :name, :latitude, :longtitude, :description, :id, :image_url, :status

  has_many :comments, serializer: CommentSerializer
  has_many :articles, serializer: ArticleSerializer
  has_many :posts, serializer: PostSerializer
end
