namespace :hotspring_task do
  desc '野湯と山のアソシエーションを追加'
  task add_spots: :environment do
    mountains = Mountain.all
    Hotspring.find_each do |hotspring|
      mountains.each do |mountain|
        if hotspring.distance(mountain.latitude, mountain.longtitude) < 10_000
          Spot.create(mountain_id: mountain.id, hotspring_id: hotspring.id)
        end
      end
    end
  end
end
