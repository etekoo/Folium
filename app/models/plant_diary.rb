class PlantDiary < ApplicationRecord
  # validates :title, presence: true
  # validates :content, presence: true

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  
  def get_diary_image
    if image.attached?
      image.variant(resize: "300x300>").processed
    else
      'diary_no_image.jpg'
    end
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @plant_diaries = PlantDiary.where("title LIKE?","#{word}")  
    elsif search == "forward_match"
      @plant_diaries = PlantDiary.where("title LIKE?","#{word}%")  
    elsif search == "backward_match"
      @plant_diaries = PlantDiary.where("title LIKE?","%#{word}")  
    elsif search == "partial_match"
      @plant_diaries = PlantDiary.where("title LIKE?","%#{word}%")  
    else
      @plant_diaries = PlantDiary.all  
    end
  end
  
end