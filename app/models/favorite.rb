class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :plant_diary

    # 通知コールバック
  after_create_commit :create_notifications

  private

  # 通知機能
  def create_notifications
    Notification.create(subject: self, user: plant_diary.user, action_type: :liked_to_own_plant_diary)
  end

end
