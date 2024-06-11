class PlantDiary < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  # 画像をリサイズして取得する
  def resize_diary_image(width, height, mode)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/diary_no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    if mode == 'fit'
      image.variant(resize_to_fit: [width, height]).processed
    elsif mode == 'fill'
      image.variant(resize_to_fill: [width, height]).processed
  # デフォルトのリサイズ方法を指定
    else
      image.variant(resize_to_fill: [800, 800]).processed
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