class Api::GoogleMapController < Api::BaseController
  require "uri"
  require "net/http"
  require "json"
  require 'nokogiri'

  def index
    render json: textSearch(params[:query])
  end

  def show
    locations = []
    locations = locations.concat(nearbySearch(params[:lat], params[:lng], 'tourist_attraction'))
    locations = locations.concat(nearbySearch(params[:lat], params[:lng], 'park'))
    render json: locations
  end

  private
  
  NearbyPlaces = Struct.new(:coordinates, :name, :photo)

  def nearbySearch(lat, lng, type)
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat+"%2C"+lng+"&radius=1500&language=ja&type="+type+"&key="+ENV['GOOGLE_PLACES_API_KEY'])

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    locations = JSON.parse(response.read_body)['results'].map do |result|
      photo_url = result['photos'] ? URI('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference='+result['photos'][0]['photo_reference']+'&language=ja&key='+ENV['GOOGLE_PLACES_API_KEY']) : nil

      photo = 'none'

      if photo_url
        https = Net::HTTP.new(photo_url.host, photo_url.port)
        https.use_ssl = true

        request = Net::HTTP::Get.new(photo_url)

        response = https.request(request)

        doc = Nokogiri::HTML(response.read_body)
        photo = doc.css('a')[0][:href]
      end

      NearbyPlaces.new(
        result['geometry']['location'],
        result['name'],
        photo
      )
    end

    return locations
  end

  TextPlaces = Struct.new(:coordinates, :name, :address)

  def textSearch(query)
    url = URI(URI.encode 'https://maps.googleapis.com/maps/api/place/textsearch/json?query='+query+'&language=ja&region=jp&key='+ENV['GOOGLE_PLACES_API_KEY'])

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    locations = JSON.parse(response.read_body)['results'].map do |result|
      TextPlaces.new(
        result['geometry']['location'],
        result['name'],
        result['formatted_address'],
      )
    end

    return locations
  end
end
