class PostSerializer
  include JSONAPI::Serializer
  attributes :hotspring_id, :user_id

  attribute :hotspring do |obj|
    HotspringOnlySerializer.new(obj.hotspring)
  end
end
