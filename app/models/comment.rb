class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :hotspring

  validates :user_id, presence: true
  validates :hotspring_id, presence: true
  validates :comment, presence: true
end
