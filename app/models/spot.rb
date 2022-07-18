class Spot < ApplicationRecord
  belongs_to :hotspring
  belongs_to :mountain

  validates :hotspring_id, uniqueness: { scope: :mountain_id }
end
