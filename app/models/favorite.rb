class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :hotspring

  validates :hotspring_id, uniqueness: { scope: :user_id }
end
