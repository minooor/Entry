class Profile < ApplicationRecord

  has_one_attached :profile_image
  belongs_to :customer

  validates :name, presence: true
  validates :category, presence: true
  validates :address, presence: true
  validates :member, presence: true
  validates :level, presence: true
  validates :activity_day, presence: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
