class PostSerializer
  include JSONAPI::Serializer
  attributes :hotspring_id, :status, :user_id
end
