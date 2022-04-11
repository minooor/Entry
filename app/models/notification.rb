class Notification < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :message, optional: true
  #通知を送った
  belongs_to :visiter, class_name: 'Customer', foreign_key: 'visiter_id', optional: true
  #通知を送られた
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id', optional: true
  
end
