class Hotspring < ApplicationRecord
  validates :latitude, presence: true
  validates :longtitude, presence: true

  enum status: { 'unexplored': 0, 'not_exist': 1, 'prohibit': 2, 'open': 3 }
end
