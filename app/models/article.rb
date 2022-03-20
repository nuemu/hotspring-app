class Article < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  belongs_to :hotspring
  belongs_to :user
end
