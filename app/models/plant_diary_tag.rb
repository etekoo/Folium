class PlantDiaryTag < ApplicationRecord
  belongs_to :plant_diary
  belongs_to :tag
  validates :plant_diary_id, presence: true
  validates :tag_id, presence: true
end