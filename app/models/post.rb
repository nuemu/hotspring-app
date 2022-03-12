class Post < ApplicationRecord
  belongs_to :hotspring
  belongs_to :user
  has_one_attached :image
end
