class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, uniqueness: true, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :articles, dependent: :destroy

  has_one_attached :avatar

  def generate_image_url
    avatar.attached? ? url_for(avatar) : nil
  end

  # More authorities in the future ? Is boolean better ?
  enum admin: { 'user': 0, 'admin': 1 }

  def level_up
    exp = 8 * posts.length + 2 * comments.length + 2 * articles.length
    level = calculate_level(exp)

    update(level: level) if self.level != level
  end

  def calculate_level(exp)
    level = 0
    if exp >= 50
      level = 5
    elsif exp >= 25
      level = 4
    elsif exp >= 15
      level = 3
    elsif exp >= 10
      level = 2
    elsif exp.positive?
      level = 1
    end
    level
  end
end
