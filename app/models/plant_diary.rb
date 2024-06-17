class PlantDiary < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

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
  def self.looks(word)
    where("title LIKE ?", "%#{word}%")
  end
  
  def favorited_by?(user)
    favorited_users.exists?(user.id)
  end

end