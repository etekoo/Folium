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
  has_many :favorites, dependent: :destroy

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
