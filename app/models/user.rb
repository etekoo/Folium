class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  has_one_attached :image
  has_many :plant_diaries, dependent: :destroy
  
  # 画像適用
  def get_profile_image
    if image.attached?
      image.variant(resize: "300x300>").processed
    else
      'user_no_image.png'
    end
  end

  # ユーザー退会時の機能制限
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  # ゲストログイン機能
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  
end
