class Hotspring < ApplicationRecord
  validates :latitude, presence: true
  validates :longtitude, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum status: { 'unexplored': 0, 'not_exist': 1, 'prohibit': 2, 'open': 3 }

  def self.permit(status)
    if status.zero?
      where(status: 'open')
    else
      all
    end
  end
end
