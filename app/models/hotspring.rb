class Hotspring < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :latitude, presence: true
  validates :longtitude, presence: true

  validates_uniqueness_of :latitude, scope: :longtitude

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validate :distance_validator

  def generate_image_url
    image.attached? ? url_for(image) : nil
  end

  enum status: { 'unexplored': 0, 'not_exist': 1, 'prohibit': 2, 'open': 3, 'others': 4 }

  def self.find_nearby(lat, lon, gap)
    gap ||= 0.000000000005
    where(latitude: (lat - gap)..(lat + gap), longtitude: (lon - gap)..(lon + gap))
  end

  def distance_validator
    hotsprings = Hotspring.find_nearby(latitude, longtitude, 10)
    distances = hotsprings.map do |hotspring|
      hotspring.distance(latitude, longtitude)
    end
    validate = distances.find { |d| d.positive? && d < 200 }
    return true if validate.nil?

    errors.add(:latitude, '200m以内')
  end

  DEG2RAD = Math::PI / 180.0

  RX = 6_378_137.000_000 # 赤道半径
  RY = 6_356_752.314_245 # 極半径

  def distance(lat, lng)
    d_x = (longtitude - lng) * DEG2RAD
    d_y = (latitude - lat) * DEG2RAD

    p = (latitude + lat) / 2.0 * DEG2RAD

    e = Math::sqrt((RX ** 2 - RY ** 2) / (RX ** 2))
    w = Math::sqrt(1 - (e ** 2) * ((Math::sin(p)) ** 2))

    m = RX * (1 - e ** 2) / (w ** 3)
    n = RX / w

    d = Math::sqrt( (d_y * m) ** 2 + (d_x * n * Math::cos(p)) ** 2 )
    return d
  end
end
