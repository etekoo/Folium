class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  enum action_type: { new_plant_diary: 0, commented_to_own_plant_diary: 1, liked_to_own_plant_diary: 2, followed_me: 3, new_message: 4}
end
