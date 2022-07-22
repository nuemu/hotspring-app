class UserSerializer
  include JSONAPI::Serializer
  attribute :name, :introduce, :level

  attribute :image_url do |object|
    object.generate_image_url
  end

  has_many :favorites
  has_many :posts, serializer: PostSerializer
  has_many :comments, serializer: CommentSerializer
  has_many :articles, serializer: ArticleSerializer
end
