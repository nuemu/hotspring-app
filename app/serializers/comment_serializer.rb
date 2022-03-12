class CommentSerializer
  include JSONAPI::Serializer
  attribute :comment

  belongs_to :user
  belongs_to :hotspring

  attribute :user do |obj|
    UserSerializer.new(obj.user)
  end
end
