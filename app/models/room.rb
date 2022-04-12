class Room < ApplicationRecord

  has_many :chats
  has_many :customer_rooms
  has_many :customers, through: :customer_rooms
  has_many :notifications, dependent: :destroy


  def create_notification_dm!(current_customer, room_id, chat_id)
    #current_customer.id以外のcustomer_idを取得
    dm_customer = CustomerRoom.where(room_id: room_id).where.not(customer_id: current_customer.id).first.customer_id
    save_notification_dm!(current_customer, chat_id, dm_customer, room_id)
  end

  def save_notification_dm!(current_customer, chat_id, visited_id, room_id)
    notification = current_customer.active_notifications.new(
      room_id: room_id,
      chat_id: chat_id,
      visited_id: visited_id,
      action: 'dm',
      checked: false
    )
    notification.save! if notification.valid?
  end

end
