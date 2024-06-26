class Tag < ApplicationRecord
  has_many :plant_diary_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :plant_diaries, through: :plant_diary_tags
  validates :name, uniqueness: true, presence: true

  def self.search_by_name(word)
    where("name LIKE ?", "%#{word}%")
  end

  def save_tags(sent_tags)
    current_tags = self.plant_diaries.pluck(:name) unless self.plant_diaries.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.plant_diaries.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new.strip)
      self.plant_diaries << new_post_tag
    end
  end
  
  def post_count
    plant_diaries.count
  end
  
end
