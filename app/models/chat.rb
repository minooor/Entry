class Chat < ApplicationRecord

  belongs_to :customer
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message,presence: true

  def create_notification_by(current_customer)
    notification = current_customer.active_notifications.new(
      chat_id: id,
      room_id: room.id,
      visited_id: customer_id,
      visiter_id: current_customer.id,
      action: 'dm',
      checked: false
      )

      notification.save if notification.valid?
  end

end
