class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
    # 通知コールバック
  after_create_commit :create_notifications

  private

  # 通知機能
  def create_notifications
    room = self.room
    recipient_user = room.users.where.not(id: self.user.id).first
    Notification.create(subject: self, user: recipient_user, action_type: :new_message)
  end
  
end
