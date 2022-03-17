class Article < ApplicationRecord
  validates :url, presence: true
  belongs_to :hotspring
end
