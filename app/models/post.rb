class Post < ApplicationRecord
  belongs_to :hotspring
  belongs_to :user

  validates :hotspring_id, uniqueness: { scope: :user_id }
end
