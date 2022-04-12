module Public::NotificationsHelper
  #helperで定義したメソッドをviewから呼び出すことができる
  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
end