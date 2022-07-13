class Spot < ApplicationRecord
  belongs_to :hotspring
  belongs_to :mountain

  validates_uniqueness_of :hotspring_id, scope: :mountain_id
end
