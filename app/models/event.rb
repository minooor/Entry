class Event < ApplicationRecord
  belongs_to :customer

  validates :content, presence: true
  validates :title, presence: true

end
