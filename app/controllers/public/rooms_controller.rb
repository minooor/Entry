class Public::RoomsController < ApplicationController
  before_action :authenticate_customer!
  def index
    # ログイン会員所属ルームID取得
    @customer_rooms = current_customer.customer_rooms
    #値の配列をフォームから送信するのに、以下のようにキー名に空の角かっこ[]のペアを追加
    my_room_ids = []

    @customer_rooms.each do |customer_room|
      my_room_ids<< customer_room.room.id
    end
    
    # 自分のroom_idでcustomer_idが自分じゃないのを取得
    @another_customer_rooms = CustomerRoom.where(room_id: my_room_ids).where.not(customer_id: current_customer.id)
  end
end
