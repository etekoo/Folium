module Public::NotificationsHelper
  def transition_path(notification)
    case notification.action_type.to_sym
    when :new_plant_diary
      plant_diary_path(notification.subject)
    when :commented_to_own_plant_diary
      if notification.subject.present? && notification.subject.plant_diary.present?
        plant_diary_path(notification.subject.plant_diary, anchor: "comment-#{notification.subject.id}")
      else
        '#'
      end
    when :liked_to_own_plant_diary
      if notification.subject.present? && notification.subject.plant_diary.present?
        plant_diary_path(notification.subject.plant_diary)
      else
        '#'
      end
    when :followed_me
      if notification.subject.present? && notification.subject.follower.present?
        user_path(notification.subject.follower)
      else
        '#'
      end
    when :new_message
      if notification.subject.present? && notification.subject.user.present?
        user_path(notification.subject.user)
      else
        '#'
      end
    else
      '#'
    end
  end
end
