class Community < ApplicationRecord
  has_one_attached :image
  belongs_to :owner, class_name: 'User'
  has_many :communitymembers, dependent: :destroy
  has_many :users, through: :communitymembers, source: :user


  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.png'
  end

  def self.looks(word)
    where("name LIKE ?", "%#{word}%")
  end

end
