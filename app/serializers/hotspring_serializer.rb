class HotspringSerializer
  include JSONAPI::Serializer

  attributes :name, :latitude, :longtitude, :description, :id, :status, :prefecture
  attribute :image_url do |object|
    if object.image_url
      object.image_url
    else
      object.generate_image_url
    end
  end

  has_many :comments, serializer: CommentSerializer
  has_many :articles, serializer: ArticleSerializer
  has_many :posts, serializer: PostSerializer
end
