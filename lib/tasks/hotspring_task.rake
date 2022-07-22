namespace :hotspring_task do
  desc '野湯と山のアソシエーションを追加'
  task add_spots: :environment do
    mountains = Mountain.all
    Hotspring.find_each do |hotspring|
      mountains.find_each do |mountain|
        if hotspring.distance(mountain.latitude, mountain.longtitude) < 10_000
          Spot.create(mountain_id: mountain.id, hotspring_id: hotspring.id)
        end
      end
    end
  end

  desc '野湯と山のアソシエーションを削除'
  task destroy_spots: :environment do
    mountains = Mountain.all
    Hotspring.find_each do |hotspring|
      relational_mountains = mountains.where(id: hotspring.spots.map{|spot| spot.mountain_id})
      relational_mountains.each do |mountain|
        if hotspring.distance(mountain.latitude, mountain.longtitude) >= 10_000
          spot = hotspring.spots.find_by(mountain_id: mountain.id)
          spot.destroy
        end
      end
    end
  end
end
