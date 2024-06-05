class PlantDiary < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_one_attached :image
  
  def get_diary_image
    if image.attached?
      image.variant(resize: "300x300>").processed
    else
      'diary_no_image.jpg'
    end
  end
  
end