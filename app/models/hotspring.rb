class Hotspring < ApplicationRecord
  validates :latitude, presence: true
  validates :longtitude, presence: true

  enum status: { 'unexplored': 0, 'not_exist': 1, 'prohibit': 2, 'open': 3 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
