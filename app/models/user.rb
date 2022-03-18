class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :name, uniqueness: true, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def post(params)
    comments << Comment.new(hotspring_id: params[:hotspring_id], comment: params[:comment]) if params[:comment]
  end
end
