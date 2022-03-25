class Hotspring < ApplicationRecord
  validates :latitude, presence: true
  validates :longtitude, presence: true

  validates_uniqueness_of :latitude, scope: :longtitude

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum status: { 'unexplored': 0, 'not_exist': 1, 'prohibit': 2, 'open': 3 }

  def self.find_between(lat, lon)
    gap = 0.000000000005
    find_by(latitude: (lat - gap)..(lat + gap), longtitude: (lon - gap)..(lon + gap))
  end
end
