class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

    # 通知コールバック
  after_create_commit :create_notifications

  private

  # 通知機能
  def create_notifications
    Notification.create(subject: self, user: followed, action_type: :followed_me)
  end

end
