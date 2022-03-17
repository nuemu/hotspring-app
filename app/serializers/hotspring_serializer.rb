class HotspringSerializer
  include JSONAPI::Serializer
  attributes :name, :latitude, :longtitude, :description, :id

  has_many :comments, serializer: CommentSerializer
  has_many :posts, serializer: PostSerializer

  attribute :comments do |obj|
    CommentSerializer.new(obj.comments)
  end

  attribute :posts do |obj|
    PostSerializer.new(obj.posts)
  end

  attribute :articles do |obj|
    ArticleSerializer.new(obj.articles)
  end
end
