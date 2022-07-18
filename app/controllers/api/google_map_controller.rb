class Api::GoogleMapController < Api::BaseController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'nokogiri'

  def show
    locations = []
    locations.concat(nearby_search(params[:lat], params[:lng], 'tourist_attraction'))
    locations.concat(nearby_search(params[:lat], params[:lng], 'park'))
    render json: locations
  end

  private

  NearbyPlaces = Struct.new(:coordinates, :name, :photo)

  def nearby_search(lat, lng, type)
    ask(lat, lng, type).map do |result|
      photo_url = nil
      if result['photos']
        photo_url = URI("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{result['photos'][0]['photo_reference']}&language=ja&key=#{ENV['GOOGLE_PLACES_API_KEY']}")
      end

      NearbyPlaces.new(result['geometry']['location'], result['name'], photo_url ? photo(photo_url) : 'none')
    end
  end

  def ask(lat, lng, type)
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat}%2C#{lng}&radius=1500&language=ja&type=#{type}&key=#{ENV['GOOGLE_PLACES_API_KEY']}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    JSON.parse(response.read_body)['results']
  end

  def photo(photo_url)
    https = Net::HTTP.new(photo_url.host, photo_url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(photo_url)

    response = https.request(request)

    doc = Nokogiri::HTML(response.read_body)
    doc.css('a')[0][:href]
  end
end
