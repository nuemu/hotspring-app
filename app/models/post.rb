class Post < ApplicationRecord
  belongs_to :hotspring
  belongs_to :user
  has_one_attached :image

  validates_uniqueness_of :hotspring_id, scope: :user_id
end
