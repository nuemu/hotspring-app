class SpotSerializer
  include JSONAPI::Serializer

  attribute :hotspring do |obj|
    HotspringSerializer.new(obj.hotspring)
  end
end
