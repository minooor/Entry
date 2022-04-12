class Room < ApplicationRecord

  has_many :chats
  has_many :customer_rooms
  has_many :customers, through: :customer_rooms
  has_many :notifications, dependent: :destroy


  def create_notification_dm!(current_customer, room_id, chat_id)
    #current_customer.id以外のcustomer_idを取得
    #一度selectしてからdistinctを実行してカラムの重複避ける
    dm_customer = CustomerRoom.select(:customer_id).where(room_id: room_id).where.not(customer_id: current_customer.id).distinct
    dm_customer.each do |dm_customer|
      save_notification_dm!(current_customer, chat_id, dm_customer['customer_id'], room_id)
    end
    # 初めてメッセージを送った場合
    if dm_customer.blank?
      visited_id = CustomerRoom.where(room_id: room_id).where.not(customer_id: current_customer.id).distinct.first.customer_id
      save_notification_dm!(current_customer, chat_id, visited_id, room_id)
    end
  end

  def save_notification_dm!(current_customer, chat_id, visited_id, room_id)
    # 複数回のコメントを考慮。１つの投稿に複数回通知する
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
