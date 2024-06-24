class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name,presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_one_attached :image
  has_many :plant_diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :communitymembers, dependent: :destroy
  has_many :communities, through: :communitymembers
  # いいね機能
  has_many :favorites, dependent: :destroy
  has_many :favorited_plant_diaries, through: :favorites, source: :plant_diary
  # フォロー機能
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # ① フォローしている人の取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # ② フォローされているの人取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  # チャット機能
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  # 通知
  has_many :notifications, dependent: :destroy

  has_many :contacts, dependent: :destroy


  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end


  # 画像をリサイズして取得する
  def resize_profile_image(width, height, mode)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/user_no_image.png')
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

  # ユーザー退会時の機能制限
  def active_for_authentication?
    super && (is_active == true)
  end

  # ゲストログイン機能
  def guest_user?
    email == 'guest@example.com'
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

# 検索方法分岐
  def self.looks(word)
    where("name LIKE ?", "%#{word}%")
  end

end
