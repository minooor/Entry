class Public::ChatsController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    rooms = current_customer.customer_rooms.pluck(:room_id)
    customer_room = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

    #roomを取得できなかった場合
    room = nil
    if customer_room.nil?
      room = Room.new
      room.save
      #customer_roomのレコードを二人分、共通のroom_idを作る
      CustomerRoom.create(customer_id: @customer.id, room_id: room.id)
      CustomerRoom.create(customer_id: current_customer.id, room_id: room.id)
    else
      room = customer_room.room
    end

    @chats = room.chats
    @chat = Chat.new(room_id: room.id)
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
