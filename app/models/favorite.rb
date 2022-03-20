class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :hotspring

  validates_uniqueness_of :hotspring_id, scope: :user_id
end
