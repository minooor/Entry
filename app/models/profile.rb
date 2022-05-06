class Profile < ApplicationRecord

  has_one_attached :profile_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :profile_comments, dependent: :destroy

  validates :category, presence: true
  validates :address, presence: true
  validates :member, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :level, presence: true
  validates :activity_day, presence: true

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  #既にいいねしているか確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
