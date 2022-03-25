class CommentSerializer
  include JSONAPI::Serializer
  attributes :comment

  belongs_to :user, serializer: AssociateUserSerializer
  belongs_to :hotspring

  attribute :user do |obj|
    AssociateUserSerializer.new(obj.user)
  end
end
