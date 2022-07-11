class Api::GoogleMapController < Api::BaseController
  require "uri"
  require "net/http"
  require "json"
  require 'nokogiri'

  def show
    locations = []
    locations = locations.concat(nearbySearch(params[:lat], params[:lng], 'tourist_attraction'))
    locations = locations.concat(nearbySearch(params[:lat], params[:lng], 'park'))
    render json: locations
  end

  private
  
  Places = Struct.new(:coordinates, :name, :photo)

  def nearbySearch(lat, lng, type)
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat+"%2C"+lng+"&radius=1500&language=ja&type="+type+"&key="+ENV['GOOGLE_PLACES_API_KEY'])

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    

    photo = /HREF=\\"(.*)\\"/.match(response.read_body)
    
    locations = JSON.parse(response.read_body)['results'].map do |result|
      photo_url = URI('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference='+result['photos'][0]['photo_reference']+'&key='+ENV['GOOGLE_PLACES_API_KEY'])

      https = Net::HTTP.new(photo_url.host, photo_url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(photo_url)

      response = https.request(request)

      doc = Nokogiri::HTML(response.read_body)

      Places.new(
        result['geometry']['location'],
        result['name'],
        doc.css('a')[0][:href]
      )
    end

    return locations
  end
end
