class PlantDiary < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :plant_diary_tags, dependent: :destroy
  has_many :tags, through: :plant_diary_tags

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

  # タグ機能
  def save_plan_tags(tags)
    current_tags = self.tags.pluck(:name)
    current_tags ||= []

    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip)
      self.tags << tag unless self.tags.include?(tag)
    end

    tags_to_delete = current_tags - tags
    self.tags.where(name: tags_to_delete).destroy_all
  end

  # 通知機能
  after_create_commit :notify_followers

  private

  def notify_followers
    follower_ids = user.follower.pluck(:id)
    if follower_ids.any?
      notifications = follower_ids.map do |follower_id|
        {
          subject_type: 'PlantDiary',
          subject_id: self.id,
          user_id: follower_id,
          action_type: 'new_plant_diary',
          created_at: Time.current,
          updated_at: Time.current
        }
      end

      Notification.insert_all(notifications)
    end
  end
end

