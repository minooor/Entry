class ProfileComment < ApplicationRecord
  belongs_to :customer
  belongs_to :profile

  validates :comment, presence: true

end
