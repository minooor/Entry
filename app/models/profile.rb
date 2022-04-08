class Profile < ApplicationRecord

  has_one_attached :profile_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy

  validates :category, presence: true
  validates :address, presence: true
  validates :member, presence: true
  validates :level, presence: true
  validates :activity_day, presence: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  #既にいいねしているか確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
