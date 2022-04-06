class Profile < ApplicationRecord

  has_one_attached :profile_image
  belongs_to :customer

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
