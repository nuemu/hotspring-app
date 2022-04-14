class Post < ApplicationRecord
  belongs_to :hotspring
  belongs_to :user
  has_one_attached :image

  enum status: { 'unexplored': 0, 'not_exist': 1, 'prohibit': 2, 'open': 3, 'others': 4 }

  validates_uniqueness_of :hotspring_id, scope: :user_id
end
