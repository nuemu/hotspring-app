class Api::PostsController < Api::BaseController
  require 'rexml/document'

  def create
    hotsprings = getVisited()

    hotsprings.each do |hotspring|
      current_user.posts << Post.new(hotspring_id: hotspring.id)
    end

    current_user.level_up

    render json: current_user.posts
  end

  def update
    post = current_user.posts.find_by(hotspring_id: params[:hotspring_id])
    post.update(post_params)

    render json: post
  end

  def getVisited()
    file = params[:file].tempfile
    content = String(file.read)
    doc = REXML::Document.new(content)

    locations = REXML::XPath.match(doc, '/gpx/trk/trkseg/trkpt').map do |location|
      {latitude: location.attribute('lat').value, longtitude: location.attribute('lon').value}
    end

    # まとめられる？
    lats = locations.map do |location|
      location[:latitude]
    end

    lons = locations.map do |location|
      location[:longtitude]
    end

    hotsprings = Hotspring.where(latitude: lats.min..lats.max, longtitude: lons.min..lons.max)

    # 計算量...
    visited = hotsprings.filter do |hotspring|
      close_enough = locations.filter do |location|
        hotspring.distance(location[:latitude].to_f, location[:longtitude].to_f) < 200
      end
      close_enough.length > 0
    end

    return visited
  end
end
