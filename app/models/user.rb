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
  
  def get_profile_image
    if image.attached?
      image.variant(resize: "300x300>").processed
    else
      'user_no_image.png'
    end
  end
  
  has_many :plant_diaries, dependent: :destroy
end
