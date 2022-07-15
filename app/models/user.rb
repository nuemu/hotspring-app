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
    amount = self.posts.length
    level = 0
    
    if amount >= 20
      level += 1
    elsif amount >= 10
      level += 1
    elsif amount >= 5
      level += 1
    elsif amount >= 2
      level += 1
    elsif amount > 0
      level += 1
    end

    if self.level != level
      self.update(level: level)
    end
  end
end
