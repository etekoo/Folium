class Community < ApplicationRecord
  has_one_attached :image
  belongs_to :owner, class_name: 'User'
  has_many :communitymembers, dependent: :destroy
  has_many :users, through: :group_users, source: :user

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.png'
  end

end
