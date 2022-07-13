class Mountain < ApplicationRecord
  has_many :spots, dependent: :destroy

  has_one_attached :image

  def generate_image_url
    image.attached? ? url_for(image) : nil
  end
end
